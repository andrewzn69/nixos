{ lib, config, ... }:

lib.mkIf (builtins.elem "fish" config.shells) {
  programs.fish.enable = true;
}
