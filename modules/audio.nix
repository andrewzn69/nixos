{ pkgs, ... }:

{
  # TODO: configure when migrating desktop

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  environment.systemPackages = with pkgs; [
    pavucontrol
    easyeffects
  ];
}
