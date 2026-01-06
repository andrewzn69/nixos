{ pkgs, ... }:

{
  programs.hyprland.enable = true;

  environment.systemPackages = with pkgs; [
    hyprpaper
    hyprpicker
    grimblast
    wl-clipboard
    swaylock
    swww
    # waybar
    dunst
    rofi
    wf-recorder
    hyprshade
  ];
}
