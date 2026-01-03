{
  zen-browser,
  firefox-addons,
  pkgs,
  ...
}:

{
  imports = [ zen-browser.homeModules.default ];

  programs.zen-browser = {
    enable = true;

    profiles.default = {
      extensions.packages = with firefox-addons.packages.${pkgs.system}; [
        ublock-origin
      ];

      settings = {
        "browser.tabs.warnOnClose" = false;
      };
    };
  };
}
