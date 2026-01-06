{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      # "~/.config/hypr/scripts/resetxdgportal.sh"
      # "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      # "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      # "/usr/lib/polkit-kde-authentication-agent-1"
      # "systemctl --user restart pipewire"
      "hyprpanel"
      "[workspace 1 silent] zen"
      "[workspace 2 silent] beeper"
      "[workspace 6 silent] spotify"
      "[workspace 7 silent] evolution"
      "[workspace 8 silent] steam"
      "syncthing --no-browser"
      # "$HOME/Development/lights/lighton.sh"
    ];
  };
}
