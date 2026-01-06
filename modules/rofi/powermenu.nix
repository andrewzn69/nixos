{ mkLiteral, theme }:

with theme;
{
  "*" = {
    background-color = colors.background;
    foreground-color = colors.foreground;
    font = fonts.main;
  };

  window = {
    fullscreen = true;
    padding = mkLiteral "40% 29%";
    transparency = "real";
    border-color = mkLiteral "transparent";
    background-color = colors.background-transparent;
  };

  mainbox = {
    enabled = true;
    spacing = 0;
    margin = 0;
    padding = 5;
    border = mkLiteral "2px solid";
    border-radius = 0;
    border-color = colors.selected;
    background-color = colors.background;
    children = map mkLiteral [
      "listview"
      "message"
    ];
  };

  listview = {
    enabled = true;
    columns = 6;
    lines = 1;
    cycle = true;
    scrollbar = false;
    layout = mkLiteral "vertical";
    reverse = false;
    fixed-height = true;
    fixed-colums = true;
    spacing = 15;
    margin = 15;
    padding = mkLiteral "0 0 0";
    border = mkLiteral "0px solid";
    border-radius = 0;
    border-color = colors.selected;
    background-color = mkLiteral "transparent";
    text-color = colors.foreground;
    cursor = "default";
  };

  element = {
    enabled = true;
    padding = 30;
    margin = 0;
    border-radius = 0;
    border-color = colors.selected;
    background-color = mkLiteral "transparent";
    text-color = colors.foreground;
    cursor = mkLiteral "pointer";
  };

  "element normal.normal" = {
    background-color = mkLiteral "transparent";
    text-color = colors.foreground;
  };

  "element selected.normal" = {
    background-color = colors.selected;
    text-color = colors.background;
  };

  element-text = {
    font = fonts.icons;
    background-color = mkLiteral "transparent";
    text-color = mkLiteral "inherit";
    cursor = mkLiteral "inherit";
    vertical-align = mkLiteral "0.5";
    horizontal-align = mkLiteral "0.5";
  };

  message = {
    enabled = true;
    padding = mkLiteral "0 0 15px 0";
    margin = 0;
    border-radius = 0;
    background-color = colors.background;
    text-color = colors.foreground;
  };

  textbox = {
    background-color = colors.background;
    text-color = colors.foreground;
    vertical-align = mkLiteral "0.5";
    horizontal-align = mkLiteral "0.5";
  };
}
