{
  pkgs,
  user,
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

  home-manager.users.${user}.xdg.dataFile."Steam/compatibilitytools.d/GE-Proton".source =
    pkgs.proton-ge-bin.steamcompattool;

  environment.systemPackages = with pkgs; [
    protonup-qt
    protontricks
    cabextract

    dxvk
    vkd3d

    winetricks
    winePackages.fonts
    faudio

    gamescope
    mangohud

    lutris

    polymc
  ];

  nixpkgs.overlays = [
    PolyMC.overlay
  ];
}
