{ mkLiteral }:

let
  mkColors = colors: builtins.mapAttrs (_: mkLiteral) colors;
in
{
  colors = mkColors {
    background = "#171A1CFF";
    background-transparent = "#171A1C95";
    background-alt = "#3D2D2BFF";
    selected = "#B36656FF";
    foreground = "#EBDBB2FF";
    active = "#98971AFF";
    urgent = "#FB4934FF";
  };

  fonts = {
    main = "Ubuntu Nerd Font 12";
    emoji = "Noto Color Emoji 27";
    icons = "Ubuntu Nerd Font 32";
  };
}
