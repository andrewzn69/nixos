{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    (nerdfonts.override {
      fonts = [
        "Ubuntu"
        "JetBrainsMono"
      ];
    })
    noto-fonts-emoji

    # TODO: add CartographCF later
  ];
}
