{ ags, pkgs, ... }:

{
  imports = [ ags.homeManagerModules.default ];

  programs.ags = {
    enable = true;
    extraPackages = [
      ags.packages.${pkgs.system}.hyprland
      ags.packages.${pkgs.system}.mpris
    ];
  };

  home.file.".config/ags" = {
    source = ./config;
    recursive = true;
  };
}
