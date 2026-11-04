{ lib, ... }:

let
  inherit (lib.generators) mkLuaInline;
  mod = "SUPER";
  term = "kitty";
  browser = "zen-twilight";
  files = "thunar";
  colorpicker = "hyprpicker -a";
  playSound = name: "soundboard play ${name}";
in

{
  wayland.windowManager.hyprland.settings = {
    config.binds = {
      workspace_back_and_forth = 1;
    };

    bind = [
      # window manipulation
      { _args = [ "${mod} + SHIFT + Q" (mkLuaInline "hl.dsp.window.close()") ]; }
      { _args = [ "${mod} + F" (mkLuaInline "hl.dsp.window.fullscreen({ mode = \"fullscreen\" })") ]; }
      { _args = [ "${mod} + Space" (mkLuaInline "hl.dsp.window.float()") ]; }
      { _args = [ "${mod} + P" (mkLuaInline "hl.dsp.window.pseudo()") ]; }

      # window focus
      { _args = [ "${mod} + h" (mkLuaInline "hl.dsp.focus({ direction = \"left\" })") ]; }
      { _args = [ "${mod} + l" (mkLuaInline "hl.dsp.focus({ direction = \"right\" })") ]; }
      { _args = [ "${mod} + k" (mkLuaInline "hl.dsp.focus({ direction = \"up\" })") ]; }
      { _args = [ "${mod} + j" (mkLuaInline "hl.dsp.focus({ direction = \"down\" })") ]; }
      { _args = [ "${mod} + left" (mkLuaInline "hl.dsp.focus({ direction = \"left\" })") ]; }
      { _args = [ "${mod} + right" (mkLuaInline "hl.dsp.focus({ direction = \"right\" })") ]; }
      { _args = [ "${mod} + up" (mkLuaInline "hl.dsp.focus({ direction = \"up\" })") ]; }
      { _args = [ "${mod} + down" (mkLuaInline "hl.dsp.focus({ direction = \"down\" })") ]; }

      { _args = [ "${mod} + Tab" (mkLuaInline "function() hl.dispatch(hl.dsp.window.cycle_next()) hl.dispatch(hl.dsp.window.alter_zorder({ mode = \"top\" })) end") ]; }

      # move window
      { _args = [ "${mod} + SHIFT + h" (mkLuaInline "hl.dsp.window.move({ direction = \"left\" })") ]; }
      { _args = [ "${mod} + SHIFT + l" (mkLuaInline "hl.dsp.window.move({ direction = \"right\" })") ]; }
      { _args = [ "${mod} + SHIFT + k" (mkLuaInline "hl.dsp.window.move({ direction = \"up\" })") ]; }
      { _args = [ "${mod} + SHIFT + j" (mkLuaInline "hl.dsp.window.move({ direction = \"down\" })") ]; }
      { _args = [ "${mod} + SHIFT + left" (mkLuaInline "hl.dsp.window.move({ direction = \"left\" })") ]; }
      { _args = [ "${mod} + SHIFT + right" (mkLuaInline "hl.dsp.window.move({ direction = \"right\" })") ]; }
      { _args = [ "${mod} + SHIFT + up" (mkLuaInline "hl.dsp.window.move({ direction = \"up\" })") ]; }
      { _args = [ "${mod} + SHIFT + down" (mkLuaInline "hl.dsp.window.move({ direction = \"down\" })") ]; }

      # resize window
      { _args = [ "${mod} + CTRL + left" (mkLuaInline "hl.dsp.window.resize({ x = -20, y = 0, relative = true })") ]; }
      { _args = [ "${mod} + CTRL + right" (mkLuaInline "hl.dsp.window.resize({ x = 20, y = 0, relative = true })") ]; }
      { _args = [ "${mod} + CTRL + up" (mkLuaInline "hl.dsp.window.resize({ x = 0, y = -20, relative = true })") ]; }
      { _args = [ "${mod} + CTRL + down" (mkLuaInline "hl.dsp.window.resize({ x = 0, y = 20, relative = true })") ]; }

      # programs
      { _args = [ "${mod} + Return" (mkLuaInline "hl.dsp.exec_cmd(\"${term}\")") ]; }
      { _args = [ "${mod} + SHIFT + Return" (mkLuaInline "hl.dsp.exec_cmd(\"${browser}\")") ]; }
      { _args = [ "${mod} + M" (mkLuaInline "hl.dsp.exec_cmd(\"${files}\")") ]; }

      # rofi
      { _args = [ "${mod} + D" (mkLuaInline "hl.dsp.exec_cmd(\"killall rofi || rofi -show drun\")") ]; }
      { _args = [ "${mod} + period" (mkLuaInline "hl.dsp.exec_cmd(\"killall rofi || rofi -show emoji -emoji-format '{emoji}' -modi emoji\")") ]; }
      { _args = [ "${mod} + code:115" (mkLuaInline "hl.dsp.exec_cmd(\"killall rofi || $HOME/.config/rofi/scripts/powermenu.sh\")") ]; }

      # color picker
      { _args = [ "${mod} + SHIFT + X" (mkLuaInline "hl.dsp.exec_cmd(\"${colorpicker}\")") ]; }

      # media controls
      { _args = [ "code:173" (mkLuaInline "hl.dsp.exec_cmd(\"playerctl --player=spotify previous\")") ]; }
      { _args = [ "code:172" (mkLuaInline "hl.dsp.exec_cmd(\"playerctl --player=spotify play-pause\")") ]; }
      { _args = [ "code:171" (mkLuaInline "hl.dsp.exec_cmd(\"playerctl --player=spotify next\")") ]; }

      # rgb control
      # { _args = [ "code:123" (mkLuaInline "hl.dsp.exec_cmd(\"$HOME/Development/lights/lightson.sh\")") ]; }
      # { _args = [ "code:121" (mkLuaInline "hl.dsp.exec_cmd(\"$HOME/Development/lights/lightsoff.sh\")") ]; }

      # hyprsunset
      { _args = [ "code:174" (mkLuaInline "hl.dsp.exec_cmd(\"pkill hyprsunset || hyprsunset -t 3000\")") ]; }

      # lock screen
      { _args = [ "${mod} + SHIFT + Tab" (mkLuaInline "hl.dsp.exec_cmd(\"swaylock -c 000000\")") ]; }

      # soundboard (files in ~/Sounds, played through the PWSP virtual mic).
      # bound bare and with ALT so they fire whether or not Alt is held --
      # Hyprland matches the exact modifier mask, so "F1" won't trigger on
      # ALT+F1 and needs its own bind.
      { _args = [ "F1" (mkLuaInline "hl.dsp.exec_cmd(\"${playSound "1.mp3"}\")") ]; }
      { _args = [ "F2" (mkLuaInline "hl.dsp.exec_cmd(\"${playSound "2.mp3"}\")") ]; }
      { _args = [ "F3" (mkLuaInline "hl.dsp.exec_cmd(\"${playSound "3.mp3"}\")") ]; }
      { _args = [ "F4" (mkLuaInline "hl.dsp.exec_cmd(\"${playSound "4.mp3"}\")") ]; }
      { _args = [ "ALT + F1" (mkLuaInline "hl.dsp.exec_cmd(\"${playSound "1.mp3"}\")") ]; }
      { _args = [ "ALT + F2" (mkLuaInline "hl.dsp.exec_cmd(\"${playSound "2.mp3"}\")") ]; }
      { _args = [ "ALT + F3" (mkLuaInline "hl.dsp.exec_cmd(\"${playSound "3.mp3"}\")") ]; }
      { _args = [ "ALT + F4" (mkLuaInline "hl.dsp.exec_cmd(\"${playSound "4.mp3"}\")") ]; }

      # mouse binds for window manipulation
      { _args = [ "${mod} + mouse:272" (mkLuaInline "hl.dsp.window.drag()") { mouse = true; } ]; }
      { _args = [ "${mod} + mouse:273" (mkLuaInline "hl.dsp.window.resize()") { mouse = true; } ]; }
    ]
    # switch workspace
    ++ (map (i: { _args = [ "${mod} + ${toString (if i == 10 then 0 else i)}" (mkLuaInline "hl.dsp.focus({ workspace = ${toString i} })") ]; }) (
      builtins.genList (x: x + 1) 10
    ))
    # move to workspace
    ++ (map (
      i: { _args = [ "${mod} + SHIFT + ${toString (if i == 10 then 0 else i)}" (mkLuaInline "hl.dsp.window.move({ workspace = ${toString i}, follow = true })") ]; }
    ) (builtins.genList (x: x + 1) 10));
  };
}
