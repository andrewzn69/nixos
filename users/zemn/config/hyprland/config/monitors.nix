{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    monitor = [
      { output = "DP-3"; mode = "1920x1080@60"; position = "840x653"; scale = 1; transform = 1; }
      { output = "DP-2"; mode = "1920x1080@60"; position = "1920x0"; scale = 1; }
      { output = "HDMI-A-1"; mode = "1920x1080@74.97"; position = "1920x1080"; scale = 1; }
    ];

    workspace_rule = [
      { workspace = "1"; monitor = "HDMI-A-1"; }
      { workspace = "2"; monitor = "DP-3"; }
      { workspace = "3"; monitor = "HDMI-A-1"; }
      { workspace = "4"; monitor = "HDMI-A-1"; }
      { workspace = "5"; monitor = "DP-3"; }
      { workspace = "6"; monitor = "DP-3"; }
      { workspace = "7"; monitor = "HDMI-A-1"; }
      { workspace = "8"; monitor = "HDMI-A-1"; }
      { workspace = "9"; monitor = "HDMI-A-1"; }
      { workspace = "10"; monitor = "HDMI-A-1"; }
    ];
  };
}
