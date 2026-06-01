{ ... }:

{
  home.sessionVariables.NVIM_THEME = "gruvbox";

  imports = [
    ../../modules/defaults.nix
    ../../modules/fish/home.nix
    ../../modules/git/home.nix
    ../../modules/hyprland/home.nix
    ../../modules/ags/home.nix
    ../../modules/neovim/home.nix
    ../../modules/browser/home.nix
    ../../modules/theme
    ../../modules/rofi
    ../../modules/obsidian.nix
    ../../modules/kitty/home.nix
  ];

  home.stateVersion = "25.11";
}
