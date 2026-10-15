{ lib, ... }:

{
  imports = [ ./home-desktop.nix ];

  wayland.windowManager.hyprland.settings = {
    monitor = lib.mkForce [
      "eDP-1,preferred,auto,2"
      ",preferred,auto,1"
    ];
    workspace = lib.mkForce [ ];
    exec-once = lib.mkForce [
      "zorya"
      "systemctl --user restart hyprpaper"
      "[workspace 1 silent] zen-twilight"
      "[workspace 2 silent] beeper"
      "[workspace 7 silent] evolution"
    ];
    input.touchpad.natural_scroll = true;
  };

  services.hyprpaper.settings.wallpaper = lib.mkForce [
    {
      monitor = "eDP-1";
      path = "$HOME/Pictures/wallpapers/gruvbox/GTIH6J.jpg";
    }
  ];

  programs.zorya.settings = {
    bar.layouts."eDP-1" = {
      left = [ "workspaces" ];
      center = [ ];
      right = [
        "cpu"
        "ram"
        "network"
        "clock"
      ];
    };
    notifications.monitor = lib.mkForce "eDP-1";
  };
}
