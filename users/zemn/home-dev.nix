{ ... }:

{
  imports = [
    ../../modules/fish/home.nix
    ../../modules/git/home.nix
    ../../modules/neovim/home.nix
    ../../modules/tmux.nix
  ];

  home.stateVersion = "25.05";
}
