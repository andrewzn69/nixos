{
  config,
  pkgs,
  ...
}:

let
  soundsDir = "$HOME/Sounds";
  stereo = [
    "FL"
    "FR"
  ];

  pwsp = pkgs.rustPlatform.buildRustPackage rec {
    pname = "pwsp";
    version = "1.12.4";

    src = pkgs.fetchFromGitHub {
      owner = "arabianq";
      repo = "pipewire-soundpad";
      tag = "v${version}";
      hash = "sha256-7uKZRY9IKVXaoh48NFLVlKj5I/LYJ6TUYGWvWA9Wa+0=";
    };

    cargoDeps = pkgs.rustPlatform.fetchCargoVendor {
      inherit pname version src;
      hash = "sha256-LeHW+GXwvEOPquIhTx0k6yTG1AmxgdHcNSmIBjRQPnA=";
    };

    # daemon and cli only, the gui is not used
    cargoBuildFlags = [
      "-p"
      "pwsp-daemon"
      "-p"
      "pwsp-cli"
    ];

    nativeBuildInputs = [
      pkgs.pkg-config
      pkgs.cmake # opusic-sys vendors+builds libopus
      pkgs.rustPlatform.bindgenHook # pipewire-sys uses bindgen against libpipewire headers
    ];

    buildInputs = [
      pkgs.pipewire
      pkgs.alsa-lib
      pkgs.openssl
    ];

    doCheck = false;

    meta = {
      description = "Play audio files through a virtual microphone via PipeWire";
      homepage = "https://github.com/arabianq/pipewire-soundpad";
      license = pkgs.lib.licenses.mit;
      platforms = pkgs.lib.platforms.linux;
      mainProgram = "pwsp-daemon";
    };
  };

  soundboard = pkgs.writeShellApplication {
    name = "soundboard";
    runtimeInputs = [ pwsp ];
    text = ''
      case "''${1:-}" in
        play)
          pwsp-cli action play --concurrent "${soundsDir}/''${2:?usage: soundboard play <file>}"
          ;;
        *)
          echo "usage: soundboard play <file>" >&2
          exit 2
          ;;
      esac
    '';
  };
in
{
  config = {
    assertions = [
      {
        assertion = config.audio.mic != null;
        message = "soundboard.nix needs audio.mic set to the mic node name";
      }
    ];

    environment.systemPackages = [
      pwsp
      soundboard
    ];

    systemd.user.services.pwsp-daemon = {
      description = "PipeWire Soundpad Daemon";
      after = [ "pipewire.service" ];
      partOf = [ "graphical-session.target" ];
      wantedBy = [ "graphical-session.target" ];

      serviceConfig = {
        ExecStart = "${pwsp}/bin/pwsp-daemon";
        Restart = "on-failure";
        RestartSec = 3;
      };
    };

    # sink to route app audio into, its source side feeds the combined mic
    services.pipewire.extraConfig.pipewire."10-soundboard-apps" = {
      "context.modules" = [
        {
          name = "libpipewire-module-loopback";
          args = {
            "capture.props" = {
              "node.name" = "soundboard_apps";
              "node.description" = "Soundboard Apps";
              "media.class" = "Audio/Sink";
              "audio.position" = stereo;
            };
            "playback.props" = {
              "node.name" = "soundboard_apps_source";
              "node.description" = "Soundboard Apps Source";
              "media.class" = "Audio/Source";
              "audio.position" = stereo;
            };
          };
        }
      ];
    };

    # real mic, pwsp and app audio mixed into one source
    services.pipewire.extraConfig.pipewire."12-mic-plus-soundboard" = {
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
                  config.audio.mic
                  "pwsp-virtual-mic"
                  "soundboard_apps_source"
                ];
          };
        }
      ];
    };
  };
}
