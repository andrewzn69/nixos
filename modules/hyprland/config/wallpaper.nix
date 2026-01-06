{ config, ... }:

{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;

      preload = [
        "$HOME/Pictures/wallpapers/gruvbox/TPR6JQ.jpg"
      ];
      wallpaper = [
        "DP-3,$HOME/Pictures/wallpapers/gruvbox/TPR6JQ.jpg"
        "HDMI-A-1,$HOME/Pictures/wallpapers/gruvbox/TPR6JQ.jpg"
      ];
    };
  };
}
