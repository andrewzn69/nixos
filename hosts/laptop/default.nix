{ user, ... }:

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
    ../../modules/greeter.nix
    ../../users/${user}

    ../../modules/hyprland
    ../../modules/audio.nix
    ../../modules/bluetooth.nix
    ../../modules/apps.nix
    ../../modules/spotify.nix
    ../../modules/file-browser
    ../../modules/fonts.nix
    ../../modules/keyring.nix
    ../../modules/gnupg.nix
    ../../modules/email.nix
  ];

  shells = [ "fish" ];
  fileBrowser = "thunar";
  spotify.soloist.enable = true;

  system.stateVersion = "26.11";
}
