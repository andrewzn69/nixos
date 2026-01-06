{ config, ... }:

{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "$HOME/Pictures/wallpapers/TPR6JQ.jpg"
      ];
      wallpaper = [
        "$HOME/Pictures/wallpapers/TPR6JQ.jpg"
      ];
    };
  };
}
