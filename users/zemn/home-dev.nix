{ nvim, ... }:

{
  imports = [
    ./shell/home.nix
    ./config/git.nix
    nvim.homeModules.default
    ./config/tmux.nix
  ];

  shell.default = "fish";
  shell.enabled = [ "fish" ];

  home.stateVersion = "25.05";
}
