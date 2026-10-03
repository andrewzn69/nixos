{ pkgs, ... }:

{
  programs.gnupg.agent = {
    enable = true;
    # curses default needs a terminal that gui apps lack
    pinentryPackage = pkgs.pinentry-gnome3;
  };
}
