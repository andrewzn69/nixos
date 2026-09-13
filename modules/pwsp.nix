{ pkgs, ... }:

let
  # PipeWire Soundpad: plays local sound files straight into their own
  # "PWSP Virtual Mic" source, for use as a hyprland-bound soundboard.
  # https://github.com/arabianq/pipewire-soundpad
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

    # only build the headless daemon + cli, skip the egui-based pwsp-gui
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
in

{
  environment.systemPackages = [ pwsp ];

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
}
