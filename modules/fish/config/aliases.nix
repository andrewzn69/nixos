{ ... }:

{
  programs.fish.shellAliases = {
    # colors
    ls = "ls --color=auto";
    la = "ls -a";

    # git
    g = "git";
    cz = "gcz";

    # nvim
    v = "nvim";
    vim = "nvim";
    vi = "nvim";
    oldvim = "vim";

    # youtube-dlp
    mp3 = "yt-dlp --extract-audio --audio-format mp3";
    mp4 = "yt-dlp -f \"bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4\"";

    # useful
    mkdir = "mkdir -p";
    rm = "rm -iv";
    mv = "mv -iv";
    cp = "cp -iv";

    # programs
    py = "python3";
    wttr = "curl wttr.in";
    pastebin = "nc termbin.com 9999";

    # kubernetes
    h = "helm";
    k = "kubectl";
    kn = "kubectl config set-context --current --namespace";
    kctx = "kubectx";

    # terraform
    tp = "terraform plan -out .tfplan";
    ta = "terraform apply .tfplan";

    # nixos
    up = "nix flake update --flake ~/.config/nixos && sudo nixos-rebuild switch --flake ~/.config/nixos#(hostname)";
  };
}
