{ config, pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ./networking.nix
    ../../modules/core
    ../../modules/development
    ../../modules/services
    ../../users/zemn
  ];

  system.stateVersion = "25.05";
}
