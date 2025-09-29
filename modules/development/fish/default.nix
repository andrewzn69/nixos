{ config, pkgs, ... }:

{
  imports = [
    ./aliases.nix
    ./prompt.nix
    ./keybinds.nix
  ];

  programs.fish = {
    enable = true;
  };
}
