{ pkgs, ... }:

{
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
    extraUpFlags = [ "--accept-routes" ];
  };

  # enable systemd-resolved for proper DNS resolution with Tailscale
  services.resolved.enable = true;

  networking.firewall = {
    checkReversePath = "loose";
    trustedInterfaces = [ "tailscale0" ];
    allowedUDPPorts = [ 41641 ];
  };

  # fix DNS resolution - add glibc NSS modules to nscd
  system.nssModules = [ pkgs.glibc ];

  # disable nsncd, use traditional nscd (nsncd has DNS resolution bugs)
  services.nscd.enableNsncd = false;
}
