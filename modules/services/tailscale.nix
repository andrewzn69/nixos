{ config, pkgs, ... }:

{
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
    extraUpFlags = [ "--accept-routes" ];
  };

  networking.firewall = {
    checkReversePath = "loose";
    trustedInterfaces = [ "tailscale0" ];
    allowedUDPPorts = [ 41641 ];
  };

  environment.etc."systemd/resolved.conf.d/lab-dns.conf".text = ''
		[Resolve]
  	DNS=10.104.27.74
  	Domains=~lab
  '';
}
