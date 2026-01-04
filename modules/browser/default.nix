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

    policies = import ./policies.nix;

    profiles.default = {
      extensions = import ./extensions.nix { inherit firefox-addons pkgs; };
      settings = import ./settings.nix;
    };
  };
}
