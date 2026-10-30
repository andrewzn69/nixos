{
  lib,
  config,
  pkgs,
  ...
}:

let
  cfg = config.spotify;
in
{
  options.spotify = {
    client.enable = lib.mkEnableOption "the Spotify desktop client and Spicetify";
    soloist.enable = lib.mkEnableOption "Spotify Soloist as a user service";
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.client.enable {
      environment.systemPackages = with pkgs; [
        spotify
        spicetify-cli

      ];
    })

    (lib.mkIf cfg.soloist.enable {
      environment.systemPackages = [ pkgs.soloist ];

      systemd.user.services.soloist = {
        description = "Spotify Soloist";
        wantedBy = [ "default.target" ];
        serviceConfig = {
          EnvironmentFile = "%h/.config/soloist/env";
          ExecStart = "${pkgs.soloist}/bin/soloist --device-name ${config.networking.hostName} --api-key \${SOLOIST_API_KEY}";
          Restart = "on-failure";
          RestartPreventExitStatus = 10;
        };
      };
    })
  ];
}
