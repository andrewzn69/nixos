{ zorya, ... }:

{
  imports = [ zorya.homeManagerModules.default ];

  programs.zorya = {
    enable = true;

    settings = {
      version = 1;

      theme = {
        colors = {
          background = "#171A1C";
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
          borderWidth = 2;
          borderRadius = 0;
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
          paddingLarge = 16;
          workspaceSpacing = 4;
          workspaceSize = 14;
          workspacePillWidth = 36;
        };
      };

      notifications = {
        enabled = true;
        monitor = "DP-3";
        corner = "top-right";
        duration = 5000;
        width = 240;
        imageSize = 64;
        maxChars = 30;
        fonts = {
          sizeApp = 10;
          sizeSummary = 14;
          sizeBody = 12;
        };
      };

      polling = {
        default = 2000;
        clock = 1000;
      };
    };
  };
}
