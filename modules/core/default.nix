{ config, pkgs, ... }:

{
  imports = [
    ./boot.nix
    ./locale.nix
    ./security.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
