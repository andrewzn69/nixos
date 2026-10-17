{
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    ansible
    awscli2
    fzf
    ripgrep
    fd
    jq
    yq
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
    ngrok
    qemu-utils
    cosign
    act
    p7zip
    psmisc # small proc filesystem utils
    just
    openssl
    file
    sqlite
    # ggshield
    kubescape
    gh
    python3Packages.trafilatura
  ];
}
