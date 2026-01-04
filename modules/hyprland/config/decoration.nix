{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    general = {
      gaps_in = 8;
      gaps_out = 10;
      border_size = 2;
      "col.active_border" = "0xff6A3837";
      "col.inactive_border" = "0xff2A2B2C";
    };

    decoration = {
      rounding = 0;
      active_opacity = 1.0;
      inactive_opacity = 1.0;

      blur = {
        enabled = false;
        # size = 6;
        # passes = 3;
        # new_optimizations = true;
        # xray = true;
        # ignore_opacity = true;
      };

      shadow = {
        enabled = false;
        # ignore_window = true;
        # offset = "1 2";
        # range = 10;
        # render_power = 5;
      };
    };
  };
}
