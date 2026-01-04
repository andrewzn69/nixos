{
  zen-browser,
  firefox-addons,
  pkgs,
  lib,
  ...
}:

let
  myExtensions = with firefox-addons.packages.${pkgs.system}; [
    ublock-origin
    dearrow
  ];

in
{
  imports = [ zen-browser.homeModules.default ];

  programs.zen-browser = {
    enable = true;

    policies = {
      # ExtensionSettings = {
      #   # block manual installations
      #   "*" = {
      #     installation_mode = "blocked";
      #     blocked_install_message = "Extension installation is managed via NixOS config";
      #   };
      # };

      ExtensionRecommendations = false;
    };

    profiles.default = {
      extensions = {
        packages = myExtensions;
        force = true;
      };

      settings = {
        "browser.tabs.warnOnClose" = false;

        "extensions.autoDisableScopes" = 0;
        "extensions.update.autoUpdateDefault" = false;
        "extensions.update.enabled" = false;
      };
    };
  };
}
