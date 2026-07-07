{ ... }:

{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;

      wallpaper = [
        {
          monitor = "DP-3";
          path = "$HOME/Pictures/wallpapers/gruvbox/GTIH6J.jpg";
        }
        {
          monitor = "HDMI-A-1";
          path = "$HOME/Pictures/wallpapers/gruvbox/GTIH6J.jpg";
        }
      ];
    };
  };
}
