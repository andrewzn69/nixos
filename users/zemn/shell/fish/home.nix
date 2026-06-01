{ lib, config, ... }:

{
  imports = [
    ./aliases.nix
    ./prompt.nix
  ];

  config = lib.mkIf (builtins.elem "fish" config.shell.enabled) {
    programs.fish.enable = true;

    # home-manager hardcodes KITTY_SHELL_INTEGRATION=no-rc, omitting no-cursor.
    # this overrides it after the kitty block runs so __ksi_schedule skips cursor management.
    programs.fish.shellInitLast = "set --global KITTY_SHELL_INTEGRATION 'no-rc no-cursor'";
  };
}
