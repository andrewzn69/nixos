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
      force = true;

      extensions.packages = with firefox-addons.packages.${pkgs.system}; [
        ublock-origin
        dearrow
      ];

      settings = {
        "browser.tabs.warnOnClose" = false;
      };
    };
  };
}
