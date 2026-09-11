{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # languages
    go
    python3
    nodejs
    pnpm

    # build tools
    gcc
    gnumake

    # linting and formatting
    biome
  ];
}
