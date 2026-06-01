{ lib, config, ... }:

lib.mkIf (builtins.elem "zsh" config.shell.enabled) {
  programs.zsh.enable = true;
  programs.zsh.initContent = "PROMPT='%F{red}%~ %f$ '";
}
