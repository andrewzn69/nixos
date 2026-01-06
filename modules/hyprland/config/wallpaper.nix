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
          path = "$HOME/Pictures/wallpapers/gruvbox/TPR6JQ.jpg";
        }
        {
          monitor = "HDMI-A-1";
          path = "$HOME/Pictures/wallpapers/gruvbox/TPR6JQ.jpg";
        }
      ];
    };
  };
}
