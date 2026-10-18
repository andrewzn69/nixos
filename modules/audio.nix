{ lib, pkgs, ... }:

{
  options.audio.mic = lib.mkOption {
    type = lib.types.nullOr lib.types.str;
    default = null;
    description = "PipeWire node name of the host's microphone.";
  };

  config = {
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };

    environment.systemPackages = with pkgs; [
      pavucontrol
      easyeffects
      snapcast
      qpwgraph
    ];
  };
}
