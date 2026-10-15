{ ... }:

{
  imports = [
    ./boot.nix
    ./hardware.nix
    ./networking.nix
    ./disks.nix

    # shared
    ../../modules/base.nix
    ../../modules/shell
    ../../modules/tools.nix
    ../../modules/android.nix
    ../../modules/greeter.nix
    ../../users/zemn

    # desktop-specific
    ../../modules/hyprland
    ../../modules/audio.nix
    ../../modules/gaming.nix
    ../../modules/apps.nix
    ../../modules/file-browser
    ../../modules/fonts.nix
    ../../modules/keyring.nix
    ../../modules/gnupg.nix
    ../../modules/email.nix
  ];

  shells = [
    "fish"
    # "zsh"
  ];
  fileBrowser = "thunar";

  services.hardware.openrgb.enable = true;

  system.stateVersion = "25.11";
}
