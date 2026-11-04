{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    config.input = {
      kb_layout = "us,cz";
      kb_variant = ",qwerty";
      # kb_options = "grp:alt_shift_toggle";
      repeat_rate = 32;
      repeat_delay = 300;
      follow_mouse = 1;
      numlock_by_default = true;
      force_no_accel = false;
      accel_profile = "flat";
    };
  };
}
