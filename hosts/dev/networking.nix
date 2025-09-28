{ config, pkgs, ... }:

{
  networking = {
    hostName = "dev";
    networkmanager.enable = true;

    # static hosts
    hosts = {
      "127.0.0.1" = [ "localhost" ];
      "::1" = [ "localhost" ];
      "100.64.100.64" = [ "dev" "homelab" ];
    };
  };
}
