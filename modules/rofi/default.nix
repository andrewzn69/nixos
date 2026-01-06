{ pkgs, config, ... }:

let
  inherit (config.lib.formats.rasi) mkLiteral;
  theme = import ./theme.nix { inherit mkLiteral; };

  drunTheme = import ./drun.nix { inherit mkLiteral theme; };
  powermenuTheme = import ./powermenu.nix { inherit mkLiteral theme; };
  emojiTheme = import ./emoji.nix { inherit mkLiteral theme; };

  powermenuScript = import ./scripts/powermenu.nix { inherit pkgs; };
in
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    theme = drunTheme;
  };

  home.file = {
    ".config/rofi/powermenu.rasi".text = pkgs.formats.rasi.generate "powermenu" powermenuTheme;
    ".config/rofi/emoji.rasi".text = pkgs.formats.rasi.generate "emoji" emojiTheme;

    ".config/rofi/scripts/powermenu.sh".source = powermenuScript;
  };
}
