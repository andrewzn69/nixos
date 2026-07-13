{ ... }:

{
  home.sessionVariables.NVIM_THEME = "gruvbox";

  imports = [
    ./shell/home.nix
    ./config/xdg.nix
    ./config/git.nix
    ./config/hyprland
    ../../modules/ags/home.nix
    ../../modules/neovim/home.nix
    ./config/browser
    ./config/theme
    ./config/rofi
    ./config/terminal
  ];

  terminal = "kitty";
  shell.default = "fish";
  shell.enabled = [ "fish" ];

  home.stateVersion = "25.11";
}
