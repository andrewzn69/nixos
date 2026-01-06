{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    windowrulev2 = [
      # float
      "float,class:^(org.kde.polkit-kde-authentication-agent-1)$"
      "float,class:^(pavucontrol)$"
      "float,class:^(file_progress)$"
      "float,class:^(confirm)$"
      "float,class:^(dialog)$"
      "float,class:^(download)$"
      "float,class:^(notification)$"
      "float,class:^(error)$"
      "float,class:^(confirmreset)$"
      "float,title:^(Media viewer)$"
      "float,title:^(Volume Control)$"
      "float,title:^(Picture-in-Picture)$"
      "float,title:^(DevTools)$"
      "float,title:^(Open File)$"
      "float,title:^(branchdialog)$"
      "float,title:^(Confirm to replace files)$"
      "float,title:^(File Operation Progress)$"

      # position
      "move 75 44%,title:^(Volume Control)$"

      # workspace
      "workspace 1,class:^(firefox)$"
      "workspace 2,class:^(vesktop)$"
      "workspace 2,class:^(org.kotatogram.desktop)$"
      # "workspace 2,class:^(beeper)$"
      "workspace 6,class:^(Spotify)$"
      "workspace 8,class:^(Steam)$"
      "workspace 8,class:^(steam)$"
      "workspace 8,class:^(steamwebhelper)$"

      # size
      "size 800 600,class:^(download)$"
      "size 800 600,class:^(Open File)$"
      "size 800 600,class:^(Save File)$"
      "size 800 600,class:^(Volume Control)$"

      # XWaylandVideoBridge
      "opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$"
      "noanim,class:^(xwaylandvideobridge)$"
      "nofocus,class:^(xwaylandvideobridge)$"
      "noinitialfocus,class:^(xwaylandvideobridge)$"
    ];
  };
}
