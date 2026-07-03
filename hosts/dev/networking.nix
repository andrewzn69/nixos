{
  config,
  lib,
  pkgs,
  ...
}:

let
  ts = config.services.tailscale.package;

  # tailscales own cgnat range
  tailscaleCidr = "100.64.0.0/10";

  # subnet route received from a tailnet peer via --accept-routes, routed
  # directly instead of through mullvad
  acceptedSubnetCidr = "10.0.0.0/24";

  # ct mark: set on the first packet of a connection so the whole connection
  # is remembered as "bypass". meta mark: what actually steers routing;
  # propagated from the ct mark in the output chains so replies/new packets
  # on an already-marked connection bypass too, without re-matching daddr.
  bypassCtMark = "0x00000f41";
  bypassFwMark = "0x6d6f6c65";
in
{
  # --- base networking ---
  networking = {
    hostName = "dev";
    networkmanager.enable = true;

    # mullvads tunnel (wg0-mullvad) only carries an ipv4 address. Leaving
    # ipv6 enabled system-wide would let traffic to ipv6-reachable
    # destinations skip the tunnel entirely and leak out directly (bad)
    enableIPv6 = false;

    hosts = {
      "127.0.0.1" = [ "localhost" ];
      "::1" = [ "localhost" ];
      # "100.64.100.64" = [
      #   "dev"
      #   "homelab"
      # ];
    };

    # writes /etc/iproute2/rt_tables.d/nixos.conf from rttablesExtraConfig -
    # unset here, so this currently does nothing until a named routing
    # table is added via networking.iproute2.rttablesExtraConfig.
    iproute2.enable = true;

    firewall = {
      # tailscale subnet-router/exit-node traffic is routinely asymmetric
      # (arrives on one interface, replies go out another), which strict
      # reverse-path filtering drops as spoofed. Redundant with
      # useRoutingFeatures = "both" below, which sets this the same way.
      checkReversePath = "loose";

      # skip local INPUT filtering for tailscale0 - tailscale already
      # enforces its own tailnet ACLs before traffic reaches this host.
      # Only affects INPUT, not FORWARD: filterForward is off (the
      # default), so this host has no FORWARD-chain filtering at all.
      trustedInterfaces = [ "tailscale0" ];

      # tailscales default udp port for its wireguard-based transport
      allowedUDPPorts = [ 41641 ];
    };

    # --- mullvad/tailscale split-tunnel ruleset ---
    # switches the nixos firewall to the nftables backend so the custom
    # table below can be declared (the modules iptables backend can not)
    nftables.enable = true;
    # checkRuleset is true by default: nixos-rebuild validates this ruleset at
    # build time, so a malformed socket/cgroupsv2 rule fails the build rather
    # than breaking the running firewall.
    nftables.tables.mullvad-tailscale = {
      family = "inet";
      content = ''
        # Populated dynamically by systemd NFTSet= with tailscaled.service's
        # cgroup v2 id. Empty at ruleset load; filled when tailscaled starts.
        # Per systemd.resource-control(5): "systemd only inserts elements to
        # (or removes from) the sets, so the related NFT rules, tables and sets
        # must be prepared elsewhere in advance."
        set tailscaled_cgroup {
          type cgroupsv2
        }

        # Inbound: mark connections destined for tailnet/accepted-subnet
        # ranges so they (and their replies) bypass the Mullvad tunnel.
        chain prerouting {
          type filter hook prerouting priority -90; policy accept;
          ip daddr ${tailscaleCidr} ct mark set ${bypassCtMark} meta mark set ${bypassFwMark};
          ip daddr ${acceptedSubnetCidr} ct mark set ${bypassCtMark} meta mark set ${bypassFwMark};
        }

        # Outbound, filter hook: same bypass logic for locally-originated
        # traffic, plus re-deriving the fw mark from an already-set ct mark
        # (first line) so later packets on a bypassed connection don't need
        # to re-match daddr.
        chain output-filter {
          type filter hook output priority -90; policy accept;
          ct mark ${bypassCtMark} meta mark set ${bypassFwMark};
          ip daddr ${tailscaleCidr} ct mark set ${bypassCtMark} meta mark set ${bypassFwMark};
          # Unidentified range, not on any interface or route on this host.
          # Disabled until identified.
          # ip daddr 192.200.0.0/24 ct mark set ${bypassCtMark} meta mark set ${bypassFwMark};
          ip daddr ${acceptedSubnetCidr} ct mark set ${bypassCtMark} meta mark set ${bypassFwMark};
        }

        # Outbound, route hook: runs at the routing-decision point so the
        # fw mark is set *before* the kernel picks an egress interface/table,
        # which is what actually makes the bypass traffic take a different
        # route than the default (Mullvad) one.
        chain output-route {
          type route hook output priority -90; policy accept;
          ct mark ${bypassCtMark} meta mark set ${bypassFwMark};
          ip daddr ${tailscaleCidr} ct mark set ${bypassCtMark} meta mark set ${bypassFwMark};
          # ip daddr 192.200.0.0/24 ct mark set ${bypassCtMark} meta mark set ${bypassFwMark};
          ip daddr ${acceptedSubnetCidr} ct mark set ${bypassCtMark} meta mark set ${bypassFwMark};
        }

        # NAT: non-bypassed traffic that goes out wg0-mullvad still needs
        # its source rewritten to Mullvad's tunnel address, since the
        # Tailscale CGNAT source address isn't routable on the internet.
        chain postrouting {
          type nat hook postrouting priority 100; policy accept;
          oifname "wg0-mullvad" ip saddr ${tailscaleCidr} masquerade;
        }
      '';
    };
  };

  # turns this host into a router - required to forward packets between
  # interfaces at all (exit-node / subnet-router role for connected devices).
  # Same underlying kernel toggle as net.ipv4.conf.all.forwarding, which
  # useRoutingFeatures = "both" below already sets - redundant with that.
  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;

  # --- mullvad vpn ---
  services.mullvad-vpn.enable = true;

  # --- tailscale ---
  services.tailscale = {
    enable = true;

    # "both" = this host is a routing client (accepts subnet routes) and
    # a routing server (advertises itself as exit node / subnet router).
    # Automatically sets checkReversePath = "loose" and enables IPv4+IPv6
    # forwarding - both also set explicitly elsewhere in this file.
    useRoutingFeatures = "both";

    authKeyFile = "/var/lib/tailscale/authkey";

    extraUpFlags = [
      # accept subnet routes advertised by other tailnet peers
      "--accept-routes"
      # offer this host as an exit node to the tailnet. Other devices still
      # need it explicitly approved/selected - that approval lives in the
      # tailscale admin console
      "--advertise-exit-node"
      # enables tailscale ssh: identity- and acl-gated ssh access via the
      # tailnet, no separate key management needed.
      "--ssh"
    ];
  };

  # orders tailscaled after mullvad/nftables and attaches its cgroup to the
  # nft set so its sockets get mullvads bypass marks.
  systemd.services.tailscaled = {
    after = [
      "mullvad-daemon.service"
      "nftables.service"
    ];
    wants = [ "mullvad-daemon.service" ];
    serviceConfig.NFTSet = "cgroup:inet:mullvad-tailscale:tailscaled_cgroup";
  };

  # nftables reload (e.g. on nixos-rebuild switch) flushes the ruleset and
  # destroys the set contents. systemd.resource-control(5): "If the firewall
  # rules are reinstalled so that the contents of NFT sets are destroyed,
  # command systemctl daemon-reload can be used to refill the sets." Run it
  # after every nftables (re)start so the bypass survives rebuilds w/o a reboot.
  # systemd/systemd#35796: daemon-reload alone isn't always sufficient to
  # refill NFTSet cgroup sets in practice.
  systemd.services.nftables.postStart = "${config.systemd.package}/bin/systemctl daemon-reload";

  # idempotent watchdog: bring tailscale up only if it is not running. Recovers
  # automatically from any boot race or `mullvad reconnect` with no manual
  # `systemctl restart tailscaled`. tailscaled itself never exits on NoState,
  # so this (not Restart=) is what guarantees unattended recovery.
  systemd.services.tailscale-healthcheck = {
    description = "Ensure tailscaled is authenticated and Running";
    after = [
      "tailscaled.service"
      "nftables.service"
    ];
    wants = [ "tailscaled.service" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = pkgs.writeShellScript "tailscale-healthcheck" ''
        set -u
        state=$(${ts}/bin/tailscale status --json 2>/dev/null \
          | ${pkgs.jq}/bin/jq -r .BackendState 2>/dev/null || echo Unknown)
        if [ "$state" != "Running" ]; then
          ${ts}/bin/tailscale up \
            --authkey "$(cat ${config.services.tailscale.authKeyFile})" \
            ${lib.concatStringsSep " " config.services.tailscale.extraUpFlags} \
            --timeout 30s || true
        fi
      '';
    };
  };
  systemd.timers.tailscale-healthcheck = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "30s";
      OnUnitActiveSec = "60s";
    };
  };

  # --- dns/nss ---
  services.resolved.enable = true;
}
