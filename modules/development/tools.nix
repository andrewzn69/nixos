{
  config,
  pkgs,
  claude-code-nix,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    # dev tools
    fzf
    ripgrep
    fd
    jq
    gawk
    wget
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
    mosh

    # etc
    claude-code-nix.packages.x86_64-linux.default
    magic-wormhole
    neofetch

    # infra
    kubectl
    kubernetes-helm # `helm` is audio synthesizer wtf??
    k9s
    kubectx
    argocd

    android-tools
  ];

  programs.adb.enable = true;
}
