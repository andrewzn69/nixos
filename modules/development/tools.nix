{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # dev tools
    fzf
    ripgrep
    fd
    git
    tree
    tmux

    # build tools
    gcc
    gnumake

    # network tools
    openssh
    rsync

    # etc
    magic-wormhole
    claude-code
  ];
}
