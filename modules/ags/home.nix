{ ags, pkgs, ... }:

{
  imports = [ ags.homeManagerModules.default ];

  programs.ags = {
    enable = true;
    extraPackages = [
      ags.packages.${pkgs.system}.hyprland
    ];
  };

  home.file.".config/ags" = {
    source = ./config;
    recursive = true;
  };
}
