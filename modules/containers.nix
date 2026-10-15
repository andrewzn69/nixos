{ pkgs, ... }:

{
  virtualisation.containers.registries.settings.unqualified-search-registries = [
    "docker.io"
    "quay.io"
  ];

  virtualisation.podman = {
    enable = true;
    dockerCompat = true; # creates docker alias for podman
  };

  environment.systemPackages = with pkgs; [
    podman-compose
  ];
}
