{ ags, ... }:

{
  imports = [ ags.homeManagerModules.default ];

  programs.ags = {
    enable = true;
  };

  # home.file.".config/ags" = {
  #   source = ./config;
  #   recursive = true;
  # };
}
