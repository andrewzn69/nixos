{ nixcord, pkgs, ... }:

{
  imports = [ nixcord.homeModules.nixcord ];

  programs.nixcord = {
    enable = true;
    vesktop.enable = true;

    quickCss = builtins.readFile ./theme.css;
    config = import ./vencord.nix;
  };

  programs.vesktop.settings = import ./settings.nix;
}
