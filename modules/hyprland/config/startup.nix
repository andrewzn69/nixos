{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      # "~/.config/hypr/scripts/resetxdgportal.sh"
      # "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      # "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      # "/usr/lib/polkit-kde-authentication-agent-1"
      # "systemctl --user restart pipewire"
      "ags run"
      "systemctl --user restart hyprpaper"
      "openrgb --profile red"
      "openrgb --profile red" # run twice since it sometimes doesnt apply correctly on the first run
      "[workspace 1 silent] zen"
      "[workspace 2 silent] beeper"
      "spotify"
      "[workspace 7 silent] evolution"
      "steam"
      "syncthing --no-browser"
      # "$HOME/Development/lights/lighton.sh"
    ];
  };
}
