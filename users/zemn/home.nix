{ ... }:

{
  imports = [
    ../../modules/hyprland/home.nix
    ../../modules/ags/home.nix
    ../../modules/browser
    ../../modules/theme.nix
  ];

  home.stateVersion = "25.11";
}
