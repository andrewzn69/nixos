{
  config,
  lib,
  pkgs,
  ...
}:

let
  ts = config.services.tailscale.package;

  # tailscale's own cgnat range
  tailscaleCidr = "100.64.0.0/10";

  # subnet route received from a tailnet peer via --accept-routes, routed
  # directly instead of through mullvad
  acceptedSubnetCidr = "10.0.0.0/24";

  # tailscale's real controlplane range (owned by tailscale inc). it is public,
  # not rfc1918, so mullvad's lan-sharing allowlist does not cover it. without a
  # bypass, control traffic gets pushed into the mullvad tunnel and refused,
  # which blocks tailscale login on boot.
  controlplaneCidr = "192.200.0.0/24";

  # ct mark: set on the first packet of a connection so the whole connection is
  # remembered as "bypass". meta mark: what actually steers routing, propagated
  # from the ct mark in the output chains so replies and later packets on an
  # already-marked connection bypass too, without re-matching daddr.
  bypassCtMark = "0x00000f41";
  bypassFwMark = "0x6d6f6c65";

  # tailscale sets this fwmark on its own underlay sockets (derp, stun, peer
  # wireguard) so those packets skip the tailscale0 device. in this split-tunnel
  # they then match ip rule 5210 (fwmark 0x80000 lookup main) and leave the
  # physical wan, where mullvad's killswitch drops them for lacking mullvad's own
  # bypass mark. matching this mark re-flags that traffic for the bypass so it is
  # allowed out instead of dropped.
  tailscaleOwnFwMark = "0x80000";
  tailscaleOwnFwMask = "0xff0000";
in
{
  # base networking
  networking = {
    hostName = "dev";
    networkmanager.enable = true;

    # mullvad's tunnel (wg0-mullvad) only carries an ipv4 address. leaving ipv6
    # enabled system-wide would let traffic to ipv6-reachable destinations skip
    # the tunnel entirely and leak out directly, which is bad.
    enableIPv6 = false;

    hosts = {
      "127.0.0.1" = [ "localhost" ];
      "::1" = [ "localhost" ];

      # controlplane resolves to ipv4 (192.200.0.x) and ipv6. with ipv6 off,
      # tailscaled still dials the ipv6 record, fails, and does not fall back, so
      # login hangs. pinning it to tailscale's ipv4 controlplane ips forces
      # ipv4-only resolution (files beat dns, so it holds even when mullvad swaps
      # the resolver). these are tailscale's ips: if they change, update them.
      "192.200.0.101" = [ "controlplane.tailscale.com" ];
      "192.200.0.102" = [ "controlplane.tailscale.com" ];
      "192.200.0.116" = [ "controlplane.tailscale.com" ];

      # "100.64.100.64" = [
      #   "dev"
      #   "homelab"
      # ];
    };

    # writes /etc/iproute2/rt_tables.d/nixos.conf from rttablesExtraConfig, unset
    # here, so this does nothing until a named routing table is added via
    # networking.iproute2.rttablesExtraConfig.
    iproute2.enable = true;

    firewall = {
      # tailscale subnet-router/exit-node traffic is routinely asymmetric
      # (arrives on one interface, replies leave another), which strict
      # reverse-path filtering drops as spoofed. redundant with
      # useRoutingFeatures = "both" below, which sets this the same way.
      checkReversePath = "loose";

      # skip local input filtering for tailscale0. tailscale already enforces its
      # own tailnet acls before traffic reaches this host. only affects input,
      # not forward: filterForward is off (the default), so this host has no
      # forward-chain filtering at all.
      trustedInterfaces = [ "tailscale0" ];

      # tailscale's default udp port for its wireguard-based transport
      allowedUDPPorts = [ 41641 ];
    };

    # mullvad/tailscale split-tunnel ruleset. switches the nixos firewall to the
    # nftables backend so the custom table below can be declared (the module's
    # iptables backend cannot).
    nftables.enable = true;
    nftables.tables.mullvad-tailscale = {
      family = "inet";
      content = ''
        # inbound: mark connections destined for tailnet or accepted-subnet
        # ranges so they and their replies bypass the mullvad tunnel.
        chain prerouting {
          type filter hook prerouting priority -90; policy accept;
          ip daddr ${tailscaleCidr} ct mark set ${bypassCtMark} meta mark set ${bypassFwMark};
          ip daddr ${acceptedSubnetCidr} ct mark set ${bypassCtMark} meta mark set ${bypassFwMark};
        }

        # outbound filter hook: same bypass logic for locally-originated traffic.
        # first line re-derives the fw mark from an already-set ct mark so later
        # packets on a bypassed connection need not re-match. second line catches
        # tailscale's own underlay by its 0x80000 fwmark.
        chain output-filter {
          type filter hook output priority -90; policy accept;
          ct mark ${bypassCtMark} meta mark set ${bypassFwMark};
          meta mark and ${tailscaleOwnFwMask} == ${tailscaleOwnFwMark} ct mark set ${bypassCtMark} meta mark set ${bypassFwMark};
          ip daddr ${tailscaleCidr} ct mark set ${bypassCtMark} meta mark set ${bypassFwMark};
          ip daddr ${controlplaneCidr} ct mark set ${bypassCtMark} meta mark set ${bypassFwMark};
          ip daddr ${acceptedSubnetCidr} ct mark set ${bypassCtMark} meta mark set ${bypassFwMark};
        }

        # outbound route hook: runs at the routing-decision point so the fw mark
        # is set before the kernel picks an egress interface and table, which is
        # what actually makes the bypass traffic take a route other than the
        # default mullvad one.
        chain output-route {
          type route hook output priority -90; policy accept;
          ct mark ${bypassCtMark} meta mark set ${bypassFwMark};
          meta mark and ${tailscaleOwnFwMask} == ${tailscaleOwnFwMark} ct mark set ${bypassCtMark} meta mark set ${bypassFwMark};
          ip daddr ${tailscaleCidr} ct mark set ${bypassCtMark} meta mark set ${bypassFwMark};
          ip daddr ${controlplaneCidr} ct mark set ${bypassCtMark} meta mark set ${bypassFwMark};
          ip daddr ${acceptedSubnetCidr} ct mark set ${bypassCtMark} meta mark set ${bypassFwMark};
        }

        # nat: non-bypassed traffic leaving wg0-mullvad still needs its source
        # rewritten to mullvad's tunnel address, since the tailscale cgnat source
        # address is not routable on the internet.
        chain postrouting {
          type nat hook postrouting priority 100; policy accept;
          oifname "wg0-mullvad" ip saddr ${tailscaleCidr} masquerade;
        }
      '';
    };
  };

  # turns this host into a router, required to forward packets between interfaces
  # at all (exit-node / subnet-router role). same kernel toggle as
  # net.ipv4.conf.all.forwarding, which useRoutingFeatures = "both" already sets,
  # so redundant with that.
  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;

  # fully unload the ipv6 stack at boot. enableIPv6 = false above only sets the
  # disable_ipv6 sysctls, which leaves af_inet6 sockets creatable, so go programs
  # (tailscaled) still try ipv6 addresses and hang on enetunreach without falling
  # back to ipv4. this makes socket(af_inet6) fail with eafnosupport so ipv6 is
  # never attempted.
  boot.kernelParams = [ "ipv6.disable=1" ];

  # mullvad vpn
  services.mullvad-vpn.enable = true;

  # tailscale
  services.tailscale = {
    enable = true;

    # "both" = this host is a routing client (accepts subnet routes) and a
    # routing server (advertises itself as exit node / subnet router). also sets
    # checkReversePath = "loose" and enables forwarding, both set explicitly
    # elsewhere in this file too.
    useRoutingFeatures = "both";

    authKeyFile = "/var/lib/tailscale/authkey";

    extraUpFlags = [
      # accept subnet routes advertised by other tailnet peers
      "--accept-routes"
      # offer this host as an exit node to the tailnet. other devices still need
      # it explicitly approved/selected in the tailscale admin console.
      "--advertise-exit-node"
      # enable tailscale ssh: identity- and acl-gated ssh over the tailnet, no
      # separate key management needed.
      "--ssh"
    ];
  };

  # order tailscaled after mullvad and nftables so the tunnel daemon and the
  # bypass ruleset both exist before it starts.
  systemd.services.tailscaled = {
    after = [
      "mullvad-daemon.service"
      "nftables.service"
    ];
    wants = [ "mullvad-daemon.service" ];
  };

  # tailscale recommends enabling udp gro forwarding on the internet-facing nic
  # to raise throughput for udp this host forwards as an exit node / subnet
  # router (clears the "udp gro forwarding is suboptimally configured" warning).
  # tailscale documents networkd-dispatcher for persistence, but this host uses
  # networkmanager, so a systemd oneshot is the equivalent. the device is pinned
  # to ens18 (the physical nic) rather than derived from `ip route get 8.8.8.8`,
  # because with mullvad up that route resolves to wg0-mullvad, the tunnel, not
  # the nic that actually carries wireguard.
  systemd.services.tailscale-udp-gro = {
    description = "Enable UDP GRO forwarding on ens18 for tailscale throughput";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.ethtool}/bin/ethtool -K ens18 rx-udp-gro-forwarding on rx-gro-list off";
    };
  };

  # idempotent watchdog: bring tailscale up only if it is not running. recovers
  # automatically from a boot race or `mullvad reconnect` with no manual
  # `systemctl restart tailscaled`. tailscaled never exits on nostate, so this
  # (not Restart=) is what guarantees unattended recovery.
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

  # dns/nss
  services.resolved.enable = true;
}
