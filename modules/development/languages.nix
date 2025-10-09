{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # programming languages
    python3
    python3Packages.pip
    nodejs
    nodePackages.npm
    pnpm

    # linting and formatting
    biome

    # shell
  ];
}
