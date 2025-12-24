{ pkgs, ... }:

{
  # TODO: configure when migrating desktop

  programs.hyprland.enable = true;

  environment.systemPackages = with pkgs; [
    hyprpaper
    hyprpicker
    waybar
    swww
    dunst
    wl-clipboard
    swaylock
    grimblast
    rofi
  ];
}
