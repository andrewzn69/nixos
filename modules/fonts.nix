{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    nerd-fonts.ubuntu
    nerd-fonts.jetbrains-mono
    noto-fonts-color-emoji

    # TODO: add CartographCF later
  ];
}
