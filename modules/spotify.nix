{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.spotify.client.enable = lib.mkEnableOption "the Spotify desktop client and Spicetify";

  config = lib.mkIf config.spotify.client.enable {
    environment.systemPackages = with pkgs; [
      spotify
      spicetify-cli
    ];
  };
}
