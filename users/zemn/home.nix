{ ... }:

{
  imports = [
    ../../modules/hyprland/home.nix
    ../../modules/ags/home.nix
    ../../modules/browser.nix
  ];

  home.stateVersion = "25.11";
}
