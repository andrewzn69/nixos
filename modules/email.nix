{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    evolution
  ];
}
