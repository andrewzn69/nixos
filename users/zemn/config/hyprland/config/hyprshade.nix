{ pkgs, ... }:

{
  home.packages = [ pkgs.hyprshade ];

  home.file.".config/hypr/shaders/vibrance2.glsl".source = ./shaders/vibrance2.glsl;
}
