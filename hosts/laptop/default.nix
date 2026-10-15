{ ... }:

{
  imports = [
    ./disks.nix
    ./firmware.nix
    ../desktop/greeter.nix

    ../../modules/base.nix
    ../../modules/shell
    ../../modules/tools.nix
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

  hardware.asahi.enable = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;

  networking.hostName = "laptop";
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.backend = "iwd";

  shells = [ "fish" ];
  fileBrowser = "thunar";

  services.upower.enable = true;
  zramSwap.enable = true;
}
