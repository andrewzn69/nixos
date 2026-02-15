{ ... }:

{
  programs.kitty = {
    enable = true;

    settings = {
      term = "xterm-kitty";
      editor = "nvim";
      shell_integration = "no-cursor";
      kitty_mod = "ctrl+shift";

      # window
      enable_audio_bell = false;
      remember_window_size = false;
      initial_window_width = 1000;
      initial_window_height = 700;
      placement_strategy = "center";
      hide_window_decorations = false;
      window_padding_width = "5 10";
      enabled_layouts = "*";
      sync_to_monitor = true;

      # cursor and mouse
      cursor_shape = "underline";
      cursor_blink_interval = "0.0";
      cursor_stop_blinking_after = "5.0";
      url_style = "single";
      url_prefixes = "http https file ftp irc mailto news git";
      detect_urls = true;

      # fonts
      font_family = "JetBrainsMono Nerd Font";
      bold_font = "auto";
      # TODO: replace with cartographcf italic
      italic_font = "auto";
      font_size = "11.0";

      foreground = "#EBDBB2";
      background = "#171A1C";
      selection_foreground = "#EBDBB2";
      selection_background = "#3C3C3C";

      cursor = "#D5C4A1";
      cursor_text_color = "#1E1E2E";

      url_color = "#F5E0DC";

      active_border_color = "#C9CBFF";
      inactive_border_color = "#575268";
      bell_border_color = "#FAE3B0";

      wayland_titlebar_color = "background";

      # 16 terminal colors
      color0 = "#1D2022";
      color8 = "#4B4B4B";
      color1 = "#CC241D";
      color9 = "#CC241D";
      color2 = "#98971A";
      color10 = "#98971A";
      color3 = "#D79921";
      color11 = "#D79921";
      color4 = "#458588";
      color12 = "#458588";
      color5 = "#B16286";
      color13 = "#B16286";
      color6 = "#689D6A";
      color14 = "#689D6A";
      color7 = "#A89984";
      color15 = "#A89984";
    };

    keybindings = {
      # clear terminal
      "ctrl+space" = "combine : clear_terminal scrollback active : send_text normal,application \\x0c";
      # delete a word
      "ctrl+backspace" = "send_text all \\x17";
    };
  };
}
