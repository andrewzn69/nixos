{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    windowrule = [
      # float
      "match:class ^(org.kde.polkit-kde-authentication-agent-1)$, float"
      "match:class ^(pavucontrol)$, float"
      "match:class ^(file_progress)$, float"
      "match:class ^(confirm)$, float"
      "match:class ^(dialog)$, float"
      "match:class ^(download)$, float"
      "match:class ^(notification)$, float"
      "match:class ^(error)$, float"
      "match:class ^(confirmreset)$, float"
      "match:title ^(Media viewer)$, float"
      "match:title ^(Volume Control)$, float"
      "match:title ^(Picture-in-Picture)$, float"
      "match:title ^(DevTools)$, float"
      "match:title ^(Open File)$, float"
      "match:title ^(branchdialog)$, float"
      "match:title ^(Confirm to replace files)$, float"
      "match:title ^(File Operation Progress)$, float"

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
      "match:class ^(xwaylandvideobridge)$, noanim"
      "match:class ^(xwaylandvideobridge)$, nofocus"
      "match:class ^(xwaylandvideobridge)$, noinitialfocus"
    ];
  };
}
