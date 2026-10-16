{ lib, ... }:

{
  imports = [ ./home-desktop.nix ];

  wayland.windowManager.hyprland.settings = {
    monitor = lib.mkForce [
      "eDP-1,preferred,auto,2"
      ",preferred,auto,1"
    ];
    workspace = lib.mkForce [
      "1,monitor:eDP-1"
      "2,monitor:eDP-1"
      "3,monitor:eDP-1"
      "4,monitor:eDP-1"
      "5,monitor:eDP-1"
      "6,monitor:eDP-1"
      "7,monitor:eDP-1"
      "8,monitor:eDP-1"
      "9,monitor:eDP-1"
      "10,monitor:eDP-1"
    ];
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

  # zen multiplies touchpad scroll by this and the screen scale, the default (40) is awful
  programs.zen-browser.profiles.default.settings."apz.gtk.pangesture.pixel_delta_mode_multiplier" =
    "5";
}
