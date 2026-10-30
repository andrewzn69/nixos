{ osConfig, ... }:

{
  services.spotifyd = {
    enable = true;

    settings.global = {
      device_name = osConfig.networking.hostName;
      device_type = "computer";
      backend = "pulseaudio";
      bitrate = 320;
      audio_format = "F32";
      volume_normalisation = false;
      disable_discovery = true;
    };
  };
}
