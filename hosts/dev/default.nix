{ ... }:

{
  imports = [
    ./boot.nix
    ./hardware.nix
    ./disks.nix
    ./networking.nix
    ../../modules/base.nix
    ../../modules/shell
    ../../modules/tools.nix
    ../../modules/languages.nix
    ../../modules/containers.nix
    ../../modules/infra.nix
    ../../modules/android.nix
    # ../../modules/tailscale.nix
    ../../users/zemn
  ];

  # vm specific services
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  shells = [ "fish" ];

  system.stateVersion = "25.05";
}
