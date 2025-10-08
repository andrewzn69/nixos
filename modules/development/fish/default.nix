{ config, pkgs, ... }:

{
  imports = [
    ./aliases.nix
    ./prompt.nix
    ./keybinds.nix
    ./ssh-tmux.nix
  ];

  programs.fish = {
    enable = true;
  };
}
