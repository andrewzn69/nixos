{ pkgs, ... }:

{
  programs.hyprland.enable = true;

  environment.systemPackages = with pkgs; [
    hyprpaper
    hyprpicker
    grimblast
    wl-clipboard
    swaylock
    # waybar
    rofi
    hyprsunset
    playerctl
  ];
}
