{ ... }:

let
  scriptsDir = "$HOME/.config/hypr/scripts";
  term = "kitty";
  browser = "zen";
  files = "thunar";
  screenshot = "${scriptsDir}/screenshit.sh";
  colorpicker = "${scriptsDir}/colorpicker.sh";
  wallpaper = "${scriptsDir}/randompape.sh";
in

{
  wayland.windowManager.hyprland.settings = {
    "$mainMod" = "SUPER";

    bind = [
      # window manipulation
      "$mainMod SHIFT, Q, killactive,"
      "$mainMod, F, fullscreen,"
      "$mainMod, Space, togglefloating,"
      "$mainMod, P, pseudo,"
      "$mainMod, S, togglesplit,"
      "$mainMod SHFIT, Space, workspaceopt, allfloat"
      "$mainMod SHFIT, P, workspaceopt, allpseudo"

      # window focus
      "$mainMod, h, movefocus, l"
      "$mainMod, l, movefocus, r"
      "$mainMod, k, movefocus, u"
      "$mainMod, j, movefocus, d"
      "$mainMod, left, movefocus, l"
      "$mainMod, right, movefocus, r"
      "$mainMod, up, movefocus, u"
      "$mainMod, down, movefocus, d"

      "$mainMod, Tab, cyclenext,"
      "$mainMod, Tab, bringactivetotop,"

      # move window
      "$mainMod SHIFT, h, movewindow, l"
      "$mainMod SHIFT, l, movewindow, r"
      "$mainMod SHIFT, k, movewindow, u"
      "$mainMod SHIFT, j, movewindow, d"
      "$mainMod SHIFT, left, movewindow, l"
      "$mainMod SHIFT, right, movewindow, r"
      "$mainMod SHIFT, up, movewindow, u"
      "$mainMod SHIFT, down, movewindow, d"

      # resize window
      "$mainMod CTRL, left, resizeactive, -20 0"
      "$mainMod CTRL, right, resizeactive, 20 0"
      "$mainMod CTRL, up, resizeactive, 0 -20"
      "$mainMod CTRL, down, resizeactive, 0 20"

      # switch workspace
      "$mainMod, 1, workspace, 1"
      "$mainMod, 2, workspace, 2"
      "$mainMod, 3, workspace, 3"
      "$mainMod, 4, workspace, 4"
      "$mainMod, 5, workspace, 5"
      "$mainMod, 6, workspace, 6"
      "$mainMod, 7, workspace, 7"
      "$mainMod, 8, workspace, 8"
      "$mainMod, 9, workspace, 9"
      "$mainMod, 0, workspace, 10"

      # move to workspace
      "$mainMod SHIFT, 1, movetoworkspace, 1"
      "$mainMod SHIFT, 2, movetoworkspace, 2"
      "$mainMod SHIFT, 3, movetoworkspace, 3"
      "$mainMod SHIFT, 4, movetoworkspace, 4"
      "$mainMod SHIFT, 5, movetoworkspace, 5"
      "$mainMod SHIFT, 6, movetoworkspace, 6"
      "$mainMod SHIFT, 7, movetoworkspace, 7"
      "$mainMod SHIFT, 8, movetoworkspace, 8"
      "$mainMod SHIFT, 9, movetoworkspace, 9"
      "$mainMod SHIFT, 0, movetoworkspace, 10"

      # programs
      "$mainMod, Return, exec, ${term}"
      "$mainMod SHIFT, Return, exec, ${browser}"
      "$mainMod, M, exec, ${files}"

      # rofi
      "$mainMod, D, exec, killall rofi || rofi -show drun"
      "$mainMod, period, exec, killall rofi || rofi -show emoji -emoji-format '{emoji}' -modi emoji"
      "$mainMod, code:115, exec, killall rofi || $HOME/.config/rofi/scripts/powermenu.sh"

      # screenshots
      ", Print, exec, ${screenshot} area"
      "SHIFT, Print, exec, ${screenshot} full"

      # recording
      "$mainMod, v, exec, notify-send 'wf-recorder' 'Recording' && wf-recorder -a -o HDMI-A-1 -c h264_vaapi -f $HOME/Videos/screenrecording/$(date +'%H:%M:%S_%d-%m-%Y.mp4')"
      "$mainMod SHIFT, v, exec, killall -s SIGINT wf-recorder && notify-send 'wf-recorder' 'Recording Stopped'"

      # color picker
      "$mainMod SHIFT, X, exec, ${colorpicker}"

      # media controls
      ", code:173, exec, playerctl --player=spotify previous"
      ", code:172, exec, playerctl --player=spotify play-pause"
      ", code:171, exec, playerctl --player=spotify next"

      # wallpaper
      "$mainMod, code:171, exec, ${wallpaper}"

      # rgb control
      # ", code:123, exec, $HOME/Development/lights/lightson.sh"
      # ", code:121, exec, $HOME/Development/lights/lightsoff.sh"

      # wlsunset
      # ", code: 174, exec wlsunset"

      # lock screen
      "$mainMod SHIFT, Tab, exec, swaylock -c 000000"
    ];

    # mouse binds for window manipulation
    bindm = [
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];
  };
}
