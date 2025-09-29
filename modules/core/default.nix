{ config, pkgs, ... }:

{
  imports = [
    ./boot.nix
    ./locale.nix
    ./security.nix
    ./environment.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
