{ lib, config, pkgs, ... }:

lib.mkIf (config.fileBrowser == "thunar") {
  programs.thunar = {
    enable = true;
    plugins = with pkgs; [
      thunar-archive-plugin
      thunar-media-tags-plugin
      thunar-volman
    ];
  };

  services.tumbler.enable = true;
  services.gvfs.enable = true;
  programs.xfconf.enable = true;
}
