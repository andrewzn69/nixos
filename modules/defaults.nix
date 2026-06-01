{ ... }:

{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      # images
      "image/bmp" = "xviewer.desktop";
      "image/gif" = "xviewer.desktop";
      "image/jpeg" = "xviewer.desktop";
      "image/jpg" = "xviewer.desktop";
      "image/png" = "xviewer.desktop";
      "image/tiff" = "xviewer.desktop";
      "image/webp" = "xviewer.desktop";
      "image/heif" = "xviewer.desktop";
      "image/avif" = "xviewer.desktop";
      "image/svg+xml" = "xviewer.desktop";

      # videos
      "audio/mpeg" = "mpv.desktop";
      "audio/ogg" = "mpv.desktop";
      "audio/flac" = "mpv.desktop";
      "audio/wav" = "mpv.desktop";
      "audio/x-wav" = "mpv.desktop";
      "audio/mp4" = "mpv.desktop";
      "audio/opus" = "mpv.desktop";
      "video/mp4" = "mpv.desktop";
      "video/x-matroska" = "mpv.desktop";
      "video/webm" = "mpv.desktop";
      "video/avi" = "mpv.desktop";
      "video/quicktime" = "mpv.desktop";
      "video/x-msvideo" = "mpv.desktop";
      "video/ogg" = "mpv.desktop";
      "video/mpeg" = "mpv.desktop";

      # documents
      "application/pdf" = "org.pwmt.zathura-pdf-mupdf.desktop";
      "application/epub+zip" = "org.pwmt.zathura-pdf-mupdf.desktop";

      # browser
      "text/html" = "zen-twilight.desktop";
      "application/xhtml+xml" = "zen-twilight.desktop";
      "x-scheme-handler/http" = "zen-twilight.desktop";
      "x-scheme-handler/https" = "zen-twilight.desktop";

      # communication
      "x-scheme-handler/mailto" = "org.gnome.Evolution.desktop";
      "x-scheme-handler/tg" = "io.github.kotatogram.desktop";

      # torrents
      "application/x-bittorrent" = "org.qbittorrent.qBittorrent.desktop";
      "x-scheme-handler/magnet" = "org.qbittorrent.qBittorrent.desktop";
    };
  };
}
