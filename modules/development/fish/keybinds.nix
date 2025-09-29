{ config, pkgs, ... }:

{
  programs.fish.interactiveShellInit = ''
    # clear terminal
    bind \x00 clear-screen
  '';
}
