{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    android-tools
    eas-cli
    gradle
    jdk17
  ];
}
