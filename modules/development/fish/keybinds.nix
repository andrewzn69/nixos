{ config, pkgs, ... }:

{
  programs.fish.interactiveShellInit = ''
    function fish_user_key_bindings
        bind ctrl-space 'clear; commandline -f repaint'
        bind \b backward-kill-word  # Ctrl+Backspace
    end
  '';
}
