{
  zen-browser,
  firefox-addons,
  pkgs,
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
      InstallAddonsPermission = {
        Default = false;
      };

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
