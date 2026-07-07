{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    android-tools
    eas-cli
    gradle
    jdk17
  ];

  virtualisation.waydroid.enable = true;
  virtualisation.waydroid.package = pkgs.waydroid-nftables;
}
