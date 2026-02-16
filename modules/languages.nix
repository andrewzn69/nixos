{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # languages
    python3
    python3Packages.pip
    nodejs
    nodePackages.npm
    pnpm

    # build tools
    gcc
    gnumake

    # linting and formatting
    biome
  ];
}
