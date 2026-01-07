{ mkLiteral }:

let
  mkColors = colors: builtins.mapAttrs (_: mkLiteral) colors;
in
{
  colors = mkColors {
    background = "#1D2022FF";
    background-transparent = "#28282895";
    background-alt = "#482626FF";
    selected = "#6A3837FF";
    foreground = "#EBDBB2FF";
    active = "#B8BB26FF";
    urgent = "#FB4934FF";
  };

  fonts = {
    main = "Ubuntu Nerd Font 12";
    emoji = "Noto Color Emoji 27";
    icons = "feather bold 32";
  };
}
