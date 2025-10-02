{ config, pkgs, ... }:

{
  imports = [
    ./fish
    ./languages.nix
    ./tools.nix
    ./editors.nix
    ./tmux.nix
    ./git.nix
  ];
}
