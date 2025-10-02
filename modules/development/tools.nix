{ config, pkgs, claude-code-nix, ... }:

{
  environment.systemPackages = with pkgs; [
    # dev tools
    fzf
    ripgrep
    fd
    git
    tree
    tmux
    btop

    # build tools
    gcc
    gnumake

    # network tools
    openssh
    rsync

    # etc
    claude-code-nix.packages.x86_64-linux.default
    magic-wormhole
    neofetch
  ];
}
