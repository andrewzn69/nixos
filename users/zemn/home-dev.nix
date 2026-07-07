{ ... }:

{
  imports = [
    ./shell/home.nix
    ../../modules/git/home.nix
    ../../modules/neovim/home.nix
    ./config/tmux.nix
  ];

  shell.default = "fish";
  shell.enabled = [ "fish" ];

  home.stateVersion = "25.05";
}
