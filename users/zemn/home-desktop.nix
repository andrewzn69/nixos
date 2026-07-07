{ ... }:

{
  home.sessionVariables.NVIM_THEME = "gruvbox";

  imports = [
    ./shell/home.nix
    ./config/xdg.nix
    ./config/git.nix
    ../../modules/hyprland/home.nix
    ../../modules/ags/home.nix
    ../../modules/neovim/home.nix
    ../../modules/browser/home.nix
    ../../modules/theme
    ../../modules/rofi
    ./config/terminal
  ];

  terminal = "kitty";
  shell.default = "fish";
  shell.enabled = [ "fish" ];

  home.stateVersion = "25.11";
}
