{ config, pkgs, ... }:

{
  programs.fish.interactiveShellInit = ''
    # clear terminal
    bind ctrl-space 'clear; commandline -f repaint'
  '';
}
