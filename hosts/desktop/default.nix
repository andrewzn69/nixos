{ ... }:

{
  imports = [
    # TODO: add these when i have actual hardware
    # ./boot.nix
    # ./hardware.nix
    # ./networking.nix

    # shared
    ../../modules/base.nix
    ../../modules/fish
    ../../modules/neovim
    ../../modules/git.nix
    ../../modules/tools.nix
    ../../modules/tailscale.nix
    ../../users/zemn

    # desktop-specific
    ../../modules/hyprland.nix
    ../../modules/audio.nix
    ../../modules/gaming.nix
    ../../modules/apps.nix
  ];

  # TODO: set when migrating
  # system.stateVersion = "25.05";
}
