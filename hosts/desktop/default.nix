{ ... }:

{
  imports = [
    ./boot.nix
    ./hardware.nix
    ./networking.nix
    ./disks.nix

    # shared
    ../../modules/base.nix
    ../../modules/fish
    ../../modules/tools.nix
    ../../modules/tailscale.nix
    ../../modules/nfs-mounts.nix
    ../../modules/android.nix
    ../../users/zemn

    # desktop-specific
    ../../modules/hyprland
    ../../modules/audio.nix
    ../../modules/gaming.nix
    ../../modules/apps.nix
    ../../modules/fonts.nix
    ../../modules/keyring.nix
  ];

  services.hardware.openrgb.enable = true;

  system.stateVersion = "25.11";
}
