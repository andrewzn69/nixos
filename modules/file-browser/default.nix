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

  config = lib.mkIf (cfg.default != "thunar") {
    programs.thunar.enable = lib.mkForce false;
    services.tumbler.enable = lib.mkForce false;
    services.gvfs.enable = lib.mkForce false;
  };
}
