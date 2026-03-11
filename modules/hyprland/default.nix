{ pkgs, ... }:

{
  programs.hyprland.enable = true;

  xdg.portal = {
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
    config = {
      hyprland = {
        default = [ "hyprland" "gtk" ];
        "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
      };
    };
  };

  environment.etc."xdg/xdg-desktop-portal/hyprland-portals.conf".text = ''
    [preferred]
    default=hyprland;gtk
    org.freedesktop.impl.portal.FileChooser=gtk
  '';

  environment.systemPackages = with pkgs; [
    hyprpaper
    hyprpicker
    grimblast
    wl-clipboard
    swaylock
    swww
    # waybar
    dunst
    rofi
    wf-recorder
    hyprshade
    hyprsunset
    playerctl
  ];
}
