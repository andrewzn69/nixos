{ ... }:

{
  imports = [
    ./boot.nix
    ./hardware.nix
    ./networking.nix
    ../../modules/base.nix
    ../../modules/fish
    ../../modules/neovim
    ../../modules/git.nix
    ../../modules/tmux.nix
    ../../modules/tools.nix
    ../../modules/languages.nix
    ../../modules/containers.nix
    ../../modules/infra.nix
    ../../modules/android.nix
    ../../modules/tailscale.nix
    ../../users/zemn
  ];

  # vm specific services
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  system.stateVersion = "25.05";
}
