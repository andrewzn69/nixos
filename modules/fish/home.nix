{ ... }:

{
  programs.fish.enable = true;

  # home-manager hardcodes KITTY_SHELL_INTEGRATION=no-rc, omitting no-cursor.
  # this overrides it after the kitty block runs so __ksi_schedule skips cursor management.
  programs.fish.shellInitLast = "set --global KITTY_SHELL_INTEGRATION 'no-rc no-cursor'";

  imports = [
    ./config/aliases.nix
    ./config/prompt.nix
  ];
}
