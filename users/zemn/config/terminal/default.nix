{ lib, config, ... }:

let
  terminals = {
    kitty = "kitty.desktop";
  };
in
{
  imports = [ ./kitty.nix ];

  options.terminal = lib.mkOption {
    type = lib.types.enum (builtins.attrNames terminals);
    default = "kitty";
  };

  config.xdg.mimeApps.defaultApplications."x-scheme-handler/terminal" =
    terminals.${config.terminal};
}
