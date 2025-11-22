{ pkgs, ... }:

{
  # TODO: configure when migrating desktop

  environment.systemPackages = with pkgs; [
    # browsers
    zen-browser

    # communication
    beeper
    vesktop
    kotatogram-desktop

    # media
    spotify
    spicetify-cli
    mpv
    gimp

    # utilities
    qbittorrent
    thunar
    gparted
    zathura
    yt-dlp
    wf-recorder
    bitwarden
  ];
}
