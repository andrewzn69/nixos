{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    general = {
      layout = "dwindle";
    };

    dwindle = {
      pseudotile = true;
      preserve_split = true;
    };

    master = {
      new_status = "master";
    };

    binds = {
      allow_workspace_cycles = true;
    };
  };
}
