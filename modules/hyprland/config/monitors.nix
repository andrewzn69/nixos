{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    monitor = [
      "DP-3,1920x1080@60,0x1080,1"
      "DP-2,1920x1080@60,1920x0,1"
      "HDMI-A-1,1920x1080@74.97300,1920x1080,1"
    ];

    workspace = [
      "1,monitor:HDMI-A-1"
      "2,monitor:DP-3"
      "3,monitor:HDMI-A-1"
      "4,monitor:HDMI-A-1"
      "5,monitor:DP-3"
      "6,monitor:DP-3"
      "7,monitor:HDMI-A-1"
      "8,monitor:HDMI-A-1"
      "9,monitor:HDMI-A-1"
      "10,monitor:HDMI-A-1"
    ];
  };
}
