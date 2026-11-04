{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    config.general = {
      layout = "dwindle";
    };

    config.dwindle = {
      preserve_split = true;
    };

    config.master = {
      new_status = "master";
    };

    config.binds = {
      allow_workspace_cycles = true;
    };
  };
}
