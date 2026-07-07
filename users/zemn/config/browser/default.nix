{
  zen-browser,
  firefox-addons,
  pkgs,
  lib,
  ...
}:

let
  extensions = import ./config/extensions.nix;
in
{
  imports = [ zen-browser.homeModules.twilight ];

  programs.zen-browser = {
    enable = true;

    policies = import ./config/policies.nix;

    profiles.default = {
      extensions = {
        packages = builtins.map (ext: firefox-addons.packages.${pkgs.system}.${ext}) (
          builtins.attrNames extensions
        );
        force = true;
        settings = lib.mapAttrs' (
          _name: value:
          lib.nameValuePair value.id {
            inherit (value) settings;
            force = true;
          }
        ) (lib.filterAttrs (_n: v: v ? settings && v.settings != { }) extensions);
      };
      search = import ./config/engines.nix { inherit pkgs; };
      settings = import ./config/settings.nix;
    };
  };
}
