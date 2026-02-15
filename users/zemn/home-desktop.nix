{ ... }:

{
  imports = [
    ../../modules/hyprland/home.nix
    ../../modules/ags/home.nix
    ../../modules/neovim/home.nix
    ../../modules/browser
    ../../modules/theme
    ../../modules/rofi
    ../../modules/vesktop
    ../../modules/obsidian.nix
    ../../modules/kitty.nix
  ];

  home.stateVersion = "25.11";
}
