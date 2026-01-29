{
  pkgs,
  lib,
  PolyMC,
  ...
}:

{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    protonup-qt
    protontricks
    cabextract

    dxvk
    vkd3d

    winetricks
    winePackages.fonts
    faudio

    gamemode
    gamescope
    mangohud

    polymc
  ];

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "steam"
      "steam-original"
      "steam-unwrapped"
      "steam-run"
    ];

  nixpkgs.overlays = [
    PolyMC.overlay
  ];
}
