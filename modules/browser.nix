{ zen-browser, ... }:

{
  imports = [ zen-browser.homeModules.default ];

  programs.zen-browser = {
    enable = true;
    # TODO: settings, plugins, theme
  };
}
