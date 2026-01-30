{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    windowrule = [
      # float
      "match:class ^(org.kde.polkit-kde-authentication-agent-1)$, float on"
      "match:class ^(pavucontrol)$, float on"
      "match:class ^(file_progress)$, float on"
      "match:class ^(confirm)$, float on"
      "match:class ^(dialog)$, float on"
      "match:class ^(download)$, float on"
      "match:class ^(notification)$, float on"
      "match:class ^(error)$, float on"
      "match:class ^(confirmreset)$, float on"
      "match:title ^(Media viewer)$, float on"
      "match:title ^(Volume Control)$, float on"
      "match:title ^(Picture-in-Picture)$, float on"
      "match:title ^(DevTools)$, float on"
      "match:title ^(Open File)$, float on"
      "match:title ^(branchdialog)$, float on"
      "match:title ^(Confirm to replace files)$, float on"
      "match:title ^(File Operation Progress)$, float on"

      # position
      "match:title ^(Volume Control)$, move 75 44%"

      # workspace
      "match:class ^(firefox)$, workspace 1"
      "match:class ^(vesktop)$, workspace 2"
      "match:class ^(org.kotatogram.desktop)$, workspace 2"
      # "match:class ^(beeper)$, workspace 2"
      "match:class ^(Spotify)$, workspace 6"
      "match:class ^(Steam)$, workspace 8"
      "match:class ^(steam)$, workspace 8"
      "match:class ^(steamwebhelper)$, workspace 8"

      # size
      "match:class ^(download)$, size 800 600"
      "match:class ^(Open File)$, size 800 600"
      "match:class ^(Save File)$, size 800 600"
      "match:title ^(Volume Control)$, size 800 600"

      # XWaylandVideoBridge
      "match:class ^(xwaylandvideobridge)$, opacity 0.0 override 0.0 override"
      "match:class ^(xwaylandvideobridge)$, no_anim on"
      "match:class ^(xwaylandvideobridge)$, no_focus on"
      "match:class ^(xwaylandvideobridge)$, no_initial_focus on"
    ];
  };
}
