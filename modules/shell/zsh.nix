{ lib, config, ... }:

lib.mkIf (builtins.elem "zsh" config.shells) {
  programs.zsh.enable = true;
}
