{ config, pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ./networking.nix
    ../../modules/core
    # ../../modules/development
    # ../../users/zemn
  ];

  system.stateVersion = "25.05";
}
