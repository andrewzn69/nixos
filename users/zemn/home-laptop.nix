{ lib, pkgs, ... }:

let
  inherit (lib.generators) mkLuaInline;
in
{
  imports = [ ./home-desktop.nix ];

  home.packages = [ pkgs.brightnessctl ];

  wayland.windowManager.hyprland.settings = {
    monitor = lib.mkForce [
      { output = "eDP-1"; mode = "preferred"; position = "auto"; scale = 2; }
      { output = ""; mode = "preferred"; position = "auto"; scale = 1; }
    ];
    workspace_rule = lib.mkForce [
      { workspace = "1"; monitor = "eDP-1"; }
      { workspace = "2"; monitor = "eDP-1"; }
      { workspace = "3"; monitor = "eDP-1"; }
      { workspace = "4"; monitor = "eDP-1"; }
      { workspace = "5"; monitor = "eDP-1"; }
      { workspace = "6"; monitor = "eDP-1"; }
      { workspace = "7"; monitor = "eDP-1"; }
      { workspace = "8"; monitor = "eDP-1"; }
      { workspace = "9"; monitor = "eDP-1"; }
      { workspace = "10"; monitor = "eDP-1"; }
    ];
    on = lib.mkForce {
      _args = [
        "hyprland.start"
        (mkLuaInline "function()
          hl.exec_cmd(\"zorya\")
          hl.exec_cmd(\"systemctl --user restart hyprpaper\")
          hl.exec_cmd(\"zen-twilight\", { workspace = \"1 silent\" })
          hl.exec_cmd(\"beeper\", { workspace = \"2 silent\" })
          hl.exec_cmd(\"evolution\", { workspace = \"7 silent\" })
        end")
      ];
    };
    config.input.touchpad.natural_scroll = true;
    bind = [
      { _args = [ "CTRL + SHIFT + 4" (mkLuaInline "hl.dsp.exec_cmd(\"grimblast copy area\")") ]; }
      { _args = [ "XF86MonBrightnessUp" (mkLuaInline "hl.dsp.exec_cmd(\"brightnessctl -e4 -n2 set 5%+\")") { locked = true; repeating = true; } ]; }
      { _args = [ "XF86MonBrightnessDown" (mkLuaInline "hl.dsp.exec_cmd(\"brightnessctl -e4 -n2 set 5%-\")") { locked = true; repeating = true; } ]; }
    ];
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
