{ zorya, ... }:

{
  imports = [ zorya.homeManagerModules.default ];

  programs.zorya = {
    enable = true;

    settings = {
      version = 1;

      theme = {
        colors = {
          background = "#232628";
          surface = "#282C2D";
          border = "#2F3131";
          muted = "#2F3131";
          text = "#EBDBB2";
          primary = "#B36656";
          secondary = "#98971A";
          tertiary = "#458588";
        };
        fonts = {
          family = "Cantarell";
          size = 14;
        };
        spacing = {
          margin = 10;
          padding = 8;
          border_width = 2;
          border_radius = 0;
        };
      };

      bar = {
        enabled = true;
        layouts = {
          "*" = {
            left = [ ];
            center = [ "workspaces" ];
            right = [ ];
          };
          "HDMI-A-1" = {
            left = [ "workspaces" ];
            center = [ "spotify" ];
            right = [ "clock" ];
          };
          "DP-3" = {
            left = [ "workspaces" ];
            center = [
              "cpu"
              "ram"
              "disk"
              "network"
            ];
            right = [ "clock" ];
          };
        };
        spacing = {
          padding_large = 16;
          workspace_spacing = 4;
          workspace_size = 14;
          workspace_pill_width = 36;
        };
      };

      notifications = {
        enabled = true;
        monitor = "DP-3";
        corner = "top-right";
        duration = 5000;
        width = 240;
        image_size = 64;
        max_chars = 30;
        fonts = {
          size_app = 10;
          size_summary = 14;
          size_body = 12;
        };
      };

      polling = {
        default = 2000;
        clock = 1000;
      };
    };
  };
}
