{ config, pkgs, ... }:

{
  imports = [
    ./fish
    ./neovim
    ./languages.nix
    ./tools.nix
    ./editors.nix
    ./tmux.nix
    ./git.nix
    ./containers.nix
  ];
}
