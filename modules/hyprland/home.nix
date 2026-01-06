{ ... }:

{
  imports = [
    ./config/monitors.nix
    ./config/input.nix
    ./config/decoration.nix
    ./config/animations.nix
    ./config/layouts.nix
    ./config/devices.nix
    ./config/keybinds.nix
    ./config/startup.nix
    ./config/windowrules.nix
    ./config/wallpaper.nix
  ];

  wayland.windowManager.hyprland.enable = true;
}
