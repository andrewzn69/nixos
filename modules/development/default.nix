{ config, pkgs, ... }:

{
  imports = [
    ./languages.nix
    ./tools.nix
    ./editors.nix
  ];
}
