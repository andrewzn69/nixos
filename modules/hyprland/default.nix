{ pkgs, ... }:

{
  programs.hyprland.enable = true;

  environment.systemPackages = with pkgs; [
    hyprpaper
    hyprpicker
    grimblast
    wl-clipboard
    swaylock
    awww
    # waybar
    rofi
    hyprsunset
    playerctl
  ];
}
