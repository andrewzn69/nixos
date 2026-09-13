{ pkgs, ... }:

let
  mic = "alsa_input.usb-Kingston_HyperX_QuadCast_S_4100-00.analog-stereo";
  stereo = [
    "FL"
    "FR"
  ];
in
{
  imports = [ ./pwsp.nix ];

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;

    # app audio mic: route an app's playback into the sink, pick the source as a mic
    extraConfig.pipewire."10-app-audio-mic" = {
      "context.modules" = [
        {
          name = "libpipewire-module-loopback";
          args = {
            "capture.props" = {
              "node.name" = "app_audio_mic_sink";
              "node.description" = "App Audio Mic (route app here)";
              "media.class" = "Audio/Sink";
              "audio.position" = stereo;
            };
            "playback.props" = {
              "node.name" = "app_audio_mic";
              "node.description" = "App Audio Mic";
              "media.class" = "Audio/Source";
              "audio.position" = stereo;
            };
          };
        }
      ];
    };

    # mic + soundboard: real mic and pwsp mixed into one source
    extraConfig.pipewire."12-mic-plus-soundboard" = {
      "context.modules" = [
        {
          name = "libpipewire-module-combine-stream";
          args = {
            "combine.mode" = "source";
            "node.name" = "mic_plus_soundboard";
            "node.description" = "Mic + Soundboard";
            "combine.props"."audio.position" = stereo;
            "stream.rules" =
              map
                (node: {
                  matches = [ { "node.name" = node; } ];
                  actions.create-stream = { };
                })
                [
                  mic
                  "pwsp-virtual-mic"
                ];
          };
        }
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    pavucontrol
    easyeffects
    snapcast
    qpwgraph
  ];
}
