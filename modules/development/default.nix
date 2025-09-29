{ config, pkgs, ... }:

{
  imports = [
    ./languages.nix
    ./tools.nix
    ./editors.nix
    ./tmux.nix
  ];
}
