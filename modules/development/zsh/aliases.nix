{ config, pkgs, ... }:

{
  programs.zsh.shellAliases = {
    # colors
    ls = "ls --color=auto";
    la = "ls -a";

    # git
    d = "/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME";
    cz = "gcz";

    # nvim
    v = "nvim";
    vim "nvim";
    vi = "nvim";
    oldvim = "vim";

    # youtube-dlp
    mp3 = "yt-dlp --extract-audio --audio-format mp3";
    mp4 = "yt-dlp -f \"bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4\"";

    # useful aliases
    mkdir = "mkdir -p";
    rm = "rm -iv";
    mv "mv -iv";
    cp = "cp -iv";

    # programs
    py = "python3";
    # cal = "cal -y";
    # freeram = "sudo sh -c 'sync; echo 3 > /proc/sys/vm/drop_caches'";
    wttr = "curl wttr.in";
    pastebin = "nc termbin.com 999";

    # kubernetes
    h = "helm";
    k = "kubectl";
    kn = "kubectl config set-context --current --namespace";
  };
}
