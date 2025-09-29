{ config, pkgs, ... }:

{
  programs.fish.interactiveShellInit = ''
    # clear terminal
    bind --erase --preset ctrl-space
    bind ctrl-space 'clear; commandline -f repaint'
  '';
}
