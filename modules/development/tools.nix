{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # dev tools
    fzf
    ripgrep
    fd

    # build tools
    gcc
    gnumake

    # network tools
    openssh
    rsync
  ];
}
