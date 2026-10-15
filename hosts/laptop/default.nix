{ ... }:

{
  imports = [
    ./disks.nix
    ./hardware.nix
    ./boot.nix

    ../../modules/base.nix
    ../../modules/shell
    ../../modules/tools.nix
    ../../modules/greeter.nix
    ../../users/zemn

    ../../modules/hyprland
    ../../modules/audio.nix
    ../../modules/apps.nix
    ../../modules/file-browser
    ../../modules/fonts.nix
    ../../modules/keyring.nix
    ../../modules/gnupg.nix
    ../../modules/email.nix
  ];

  networking.hostName = "laptop";
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.backend = "iwd";

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

  shells = [ "fish" ];
  fileBrowser = "thunar";

  zramSwap.enable = true;

  system.stateVersion = "26.11";
}
