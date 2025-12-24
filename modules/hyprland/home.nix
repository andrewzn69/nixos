{ ... }:

{
  imports = [
    ./monitors.nix
    ./input.nix
    ./decoration.nix
    ./animations.nix
    ./layouts.nix
    ./devices.nix
    ./keybinds.nix
    ./startup.nix
    ./windowrules.nix
  ];

  wayland.windowManager.hyprland.enable = true;
}
