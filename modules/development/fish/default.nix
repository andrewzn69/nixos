{ config, pkgs, ... }:

{
  imports = [
    ./aliases.nix
    ./prompt.nix
  ];

  programs.fish = {
    enable = true;
  };
}
