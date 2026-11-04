{ lib, ... }:

{
  wayland.windowManager.hyprland.settings = {
    on = {
      _args = [
        "hyprland.start"
        (lib.generators.mkLuaInline "function()
          -- hl.exec_cmd(\"~/.config/hypr/scripts/resetxdgportal.sh\")
          -- hl.exec_cmd(\"dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP\")
          -- hl.exec_cmd(\"systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP\")
          -- hl.exec_cmd(\"/usr/lib/polkit-kde-authentication-agent-1\")
          -- hl.exec_cmd(\"systemctl --user restart pipewire\")
          hl.exec_cmd(\"zorya\")
          hl.exec_cmd(\"systemctl --user restart hyprpaper\")
          hl.exec_cmd(\"zen-twilight\", { workspace = \"1 silent\" })
          hl.exec_cmd(\"beeper\", { workspace = \"2 silent\" })
          hl.exec_cmd(\"TeamSpeak\", { workspace = \"2 silent\" })
          hl.exec_cmd(\"spotify\", { workspace = \"6 silent\" })
          hl.exec_cmd(\"evolution\", { workspace = \"7 silent\" })
          hl.exec_cmd(\"steam\", { workspace = \"8 silent\" })
          hl.exec_cmd(\"bash -c 'sleep 3 && openrgb --profile red'\")
          -- hl.exec_cmd(\"$HOME/Development/lights/lighton.sh\")
        end")
      ];
    };
  };
}
