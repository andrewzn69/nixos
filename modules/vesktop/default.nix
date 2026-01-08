{ nixcord, pkgs, ... }:

{
  imports = [ nixcord.homeModules.nixcord ];

  programs.nixcord = {
    enable = true;
    vesktop.enable = true;

    config = import ./vencord.nix;
    extraConfig.theme = builtins.readFile ./theme.css;
  };

  programs.vesktop.settings = import ./settings.nix;
}
