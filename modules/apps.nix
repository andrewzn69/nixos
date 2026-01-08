{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # communication
    beeper
    kotatogram-desktop

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
    thunar
    pavucontrol
    gparted
    zathura
    yt-dlp
    wf-recorder
    bitwarden-desktop
    kitty
    scrcpy
  ];
}
