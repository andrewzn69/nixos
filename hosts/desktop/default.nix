{ ... }:

{
  imports = [
    # ./boot.nix
    # ./hardware.nix
    # ./networking.nix
    ./defaultsettings.nix

    # shared
    ../../modules/base.nix
    ../../modules/fish
    ../../modules/tools.nix
    ../../modules/tailscale.nix
    ../../modules/nfs-mounts.nix
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
}
