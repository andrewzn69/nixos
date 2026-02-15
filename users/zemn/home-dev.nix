{ ... }:

{
  imports = [
    ../../modules/neovim/home.nix
    ../../modules/tmux.nix
  ];

  home.stateVersion = "25.05";
}
