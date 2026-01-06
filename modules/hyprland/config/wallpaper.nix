{ config, ... }:

{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "$HOME/Pictures/wallpapers/gruvbox/TPR6JQ.jpg"
      ];
      wallpaper = [
        "$HOME/Pictures/wallpapers/gruvbox/TPR6JQ.jpg"
      ];
    };
  };
}
