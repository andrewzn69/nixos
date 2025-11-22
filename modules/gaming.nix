{ pkgs, ... }:

{
  # TODO: configure when migrating desktop

  programs.steam.enable = true;

  environment.systemPackages = with pkgs; [
    protonup-qt
    protontricks
  ];
}
