{
  pkgs,
  claude-code-nix,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    fzf
    ripgrep
    fd
    jq
    gawk
    wget
    tree
    btop
    dnsutils
    openssh
    rsync
    mosh
    magic-wormhole
    fastfetch
    nfs-utils
    claude-code-nix.packages.x86_64-linux.default
  ];
}
