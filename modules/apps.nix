{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # communication
    beeper
    kotatogram-desktop
    teamspeak6-client

    # media
    spotify
    spicetify-cli
    jellyfin-mpv-shim
    jellyfin-desktop
    mpv
    gimp
    xviewer

    # utilities
    qbittorrent
    gparted
    zathura
    yt-dlp
    wf-recorder
    # bitwarden-desktop # pulls in insecure/EOL electron-39.8.10
    scrcpy
    rustdesk
    obsidian
    monero-gui
  ];
}
