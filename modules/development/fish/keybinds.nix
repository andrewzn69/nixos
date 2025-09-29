{ config, pkgs, ... }:

{
  programs.fish.interactiveShellInit = ''
    function fish_user_key_bindings
      bind \x0c 'clear; commandline -f repaint'
    end
  '';
}
