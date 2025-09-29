{ config, pkgs, ... }:

{
  programs.fish.interactiveShellInit = ''
    function fish_user_key_bindings
      bind --erase --preset ctrl-space
      bind ctrl-space 'clear; commandline -f repaint'
    end
  '';
}
