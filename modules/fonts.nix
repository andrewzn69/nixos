{ pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      nerd-fonts.ubuntu
      nerd-fonts.jetbrains-mono
      nerd-fonts.symbols-only
      noto-fonts-color-emoji
      corefonts
      cantarell-fonts
      # TODO: add CartographCF later
    ];

    fontconfig = {
      enable = true;
      antialias = true;

      hinting = {
        enable = true;
        style = "slight";
      };

      subpixel = {
        rgba = "rgb";
        lcdfilter = "default";
      };
    };
  };
}
