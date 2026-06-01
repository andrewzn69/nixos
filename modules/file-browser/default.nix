{ lib, config, ... }:

let
  desktopFiles = {
    thunar = "thunar.desktop";
  };
in
{
  imports = [ ./thunar.nix ];

  options.fileBrowser = lib.mkOption {
    type = lib.types.enum (builtins.attrNames desktopFiles);
    default = "thunar";
  };

  config.home-manager.users.zemn.xdg.mimeApps.defaultApplications."inode/directory" =
    desktopFiles.${config.fileBrowser};
}
