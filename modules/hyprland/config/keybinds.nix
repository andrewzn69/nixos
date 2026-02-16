{ ... }:

let
  scriptsDir = "$HOME/.config/hypr/scripts";
  term = "kitty";
  browser = "zen-twilight";
  files = "thunar";
  screenshot = "${scriptsDir}/screenshit.sh";
  colorpicker = "${scriptsDir}/colorpicker.sh";
  wallpaper = "${scriptsDir}/randompape.sh";
in

{
  wayland.windowManager.hyprland.settings = {
    "$mainMod" = "SUPER";

    binds = {
      workspace_back_and_forth = true;
    };

    bind = [
      # window manipulation
      "$mainMod SHIFT, Q, killactive,"
      "$mainMod, F, fullscreen,"
      "$mainMod, Space, togglefloating,"
      "$mainMod, P, pseudo,"
      "$mainMod, S, togglesplit,"
      "$mainMod SHIFT, Space, workspaceopt, allfloat"
      "$mainMod SHIFT, P, workspaceopt, allpseudo"

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

      # hyprsunset
      ", code:174, exec, pkill hyprsunset || hyprsunset -t 3000"

      # lock screen
      "$mainMod SHIFT, Tab, exec, swaylock -c 000000"
    ]
    # switch workspace
    ++ (map (i: "$mainMod, ${toString (if i == 10 then 0 else i)}, workspace, ${toString i}") (
      builtins.genList (x: x + 1) 10
    ))
    # move to workspace
    ++ (map (
      i: "$mainMod SHIFT, ${toString (if i == 10 then 0 else i)}, movetoworkspace, ${toString i}"
    ) (builtins.genList (x: x + 1) 10));

    # mouse binds for window manipulation
    bindm = [
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];
  };
}
