{ pkgs, ... }:

{
  # TODO: configure when migrating desktop

  environment.systemPackages = with pkgs; [
    # browsers
    # zen-browser

    # communication
    beeper
    vesktop
    kotatogram-desktop

    # media
    spotify
    spicetify-cli
    jellyfin-mpv-shim
    jellyfin-desktop
    mpv
    gimp

    # utilities
    qbittorrent
    xfce.thunar
    pavucontrol
    gparted
    zathura
    yt-dlp
    wf-recorder
    bitwarden-desktop
    kitty
  ];
}
