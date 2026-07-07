{ ... }:

{
  networking.hostName = "desktop";
  networking.networkmanager.enable = true;

  # tailscale client: uses dev as exit node and accepts advertised subnet routes
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
    openFirewall = true;
    extraUpFlags = [
      "--accept-routes"
      "--exit-node=100.64.100.1"
      "--exit-node-allow-lan-access=true"
    ];
  };
}
