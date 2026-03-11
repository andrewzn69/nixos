{ pkgs, ... }:

{
  programs.hyprland.enable = true;

  xdg.portal = {
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config = {
      hyprland = {
        default = [ "hyprland" "gtk" ];
        FileChooser = [ "gtk" ];
      };
    };
  };

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
