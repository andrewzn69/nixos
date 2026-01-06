{ ... }:

{
  imports = [
    ../../modules/hyprland/home.nix
    ../../modules/ags/home.nix
    ../../modules/browser
    ../../modules/theme.nix
    ../../modules/rofi
  ];

  home.stateVersion = "25.11";
}
