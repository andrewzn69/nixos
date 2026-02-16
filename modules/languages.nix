{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # languages
    python3
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
