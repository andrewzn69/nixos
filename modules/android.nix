{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    android-tools
    eas-cli
  ];

  programs.adb.enable = true;
}
