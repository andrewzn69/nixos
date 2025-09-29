{ config, pkgs, ... }:

{
  programs.zsh = {
    history = {
      size = 100000;
      save = 100000;
      # path = "$XDG_CONFIG_HOME/zsh/.zhistory";  # nixos handles zsh history differently i think
    };

    initExtra = ''
      # emacs keybinds
      bindkey -e
      bindkey '^[[1;5C' forward-word
      bindkey '^[[1;5D' backward-word
    '';
  };
}
