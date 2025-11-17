{ pkgs, ... }:

{
  virtualisation.containers.registries.search = [
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
