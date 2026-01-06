{ mkLiteral, theme }:

with theme;
{
  "*" = {
    background-color = colors.background;
    foreground-color = colors.foreground;
    border-color = colors.selected;
    font = fonts.main;
  };

  window = {
    fullscreen = true;
    padding = mkLiteral "23% 37%";
    transparency = "real";
    background-color = colors.background-transparent;
    border-color = mkLiteral "transparent";
  };

  mainbox = {
    enabled = true;
    spacing = 0;
    margin = 0;
    padding = 10;
    border = mkLiteral "2px solid";
    border-radius = 0;
    border-color = colors.selected;
    background-color = colors.background;
    children = map mkLiteral [
      "inputbar"
      "listview"
    ];
  };

  inputbar = {
    enabled = true;
    spacing = 28;
    margin = 0;
    padding = 15;
    border = mkLiteral "0px solid";
    border-color = colors.selected;
    background-color = colors.background;
    text-color = colors.foreground;
    children = map mkLiteral [
      "promt"
      "entry"
    ];
  };

  prompt = {
    enabled = true;
    background-color = mkLiteral "inherit";
    text-color = mkLiteral "inherit";
  };

  entry = {
    enabled = true;
    background-color = mkLiteral "inherit";
    text-color = mkLiteral "inherit";
    cursor = mkLiteral "text";
    placeholder = "Search...";
    placeholder-color = mkLiteral "inherit";
  };

  listview = {
    columns = 1;
    lines = 6;
    cycle = true;
    dynamic = true;
    scrollbar = false;
    layout = mkLiteral "vertical";
    reverse = false;
    fixed-height = true;
    fixed-columns = true;
    spacing = 5;
    margin = 0;
    padding = mkLiteral "23 0 0";
    border = mkLiteral "0px solid";
    border-radius = 0;
    border-color = colors.selected;
    background-color = mkLiteral "transparent";
    text-color = colors.foreground;
    cursor = "default";
  };

  element = {
    enabled = true;
    spacing = 10;
    margin = 0;
    padding = 8;
    border = mkLiteral "0px solid";
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
    background-color = colors.background-alt;
    text-color = colors.foreground;
  };

  element-icon = {
    background-color = mkLiteral "transparent";
    text-color = mkLiteral "inherit";
    size = 32;
    cursor = mkLiteral "inherit";
  };

  element-text = {
    background-color = mkLiteral "transparent";
    text-color = mkLiteral "inherit";
    highlight = mkLiteral "inherit";
    cursor = mkLiteral "inherit";
    vertical-align = mkLiteral "0.5";
    horizontal-align = mkLiteral "0.0";
  };
}
