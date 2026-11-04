{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    window_rule = [
      # float
      { match.class = "^(org.kde.polkit-kde-authentication-agent-1)$"; float = true; }
      { match.class = "^(pavucontrol)$"; float = true; }
      { match.class = "^(file_progress)$"; float = true; }
      { match.class = "^(confirm)$"; float = true; }
      { match.class = "^(dialog)$"; float = true; }
      { match.class = "^(download)$"; float = true; }
      { match.class = "^(notification)$"; float = true; }
      { match.class = "^(error)$"; float = true; }
      { match.class = "^(confirmreset)$"; float = true; }
      { match.title = "^(Media viewer)$"; float = true; }
      { match.title = "^(Volume Control)$"; float = true; }
      { match.title = "^(Picture-in-Picture)$"; float = true; }
      { match.title = "^(DevTools)$"; float = true; }
      { match.title = "^(Open File)$"; float = true; }
      { match.title = "^(branchdialog)$"; float = true; }
      { match.title = "^(Confirm to replace files)$"; float = true; }
      { match.title = "^(File Operation Progress)$"; float = true; }

      # position
      { match.title = "^(Volume Control)$"; move = [ 75 "monitor_h * 0.44" ]; }

      # workspace
      { match.class = "^(firefox)$"; workspace = "1"; }
      { match.class = "^(org.kotatogram.desktop)$"; workspace = "2"; }
      # { match.class = "^(beeper)$"; workspace = "2"; }
      { match.class = "^(Spotify)$"; workspace = "6"; }
      { match.class = "^(Steam)$"; workspace = "8"; }
      { match.class = "^(steam)$"; workspace = "8"; }
      { match.class = "^(steamwebhelper)$"; workspace = "8"; }

      # size
      { match.class = "^(download)$"; size = [ 800 600 ]; }
      { match.class = "^(Open File)$"; size = [ 800 600 ]; }
      { match.class = "^(Save File)$"; size = [ 800 600 ]; }
      { match.title = "^(Volume Control)$"; size = [ 800 600 ]; }

      # XWaylandVideoBridge
      { match.class = "^(xwaylandvideobridge)$"; opacity = "0.0 override 0.0 override"; }
      { match.class = "^(xwaylandvideobridge)$"; no_anim = true; }
      { match.class = "^(xwaylandvideobridge)$"; no_focus = true; }
      { match.class = "^(xwaylandvideobridge)$"; no_initial_focus = true; }
    ];
  };
}
