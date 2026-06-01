{ lib, config, ... }:

let
  cfg = config.fileBrowser;
in
{
  imports = [ ./thunar.nix ];

  options.fileBrowser.default = lib.mkOption {
    type = lib.types.enum [ "thunar" ];
    default = "thunar";
  };

  config.home-manager.users.zemn.xdg.mimeApps.defaultApplications."inode/directory" =
    desktopFiles.${config.fileBrowser};
}
