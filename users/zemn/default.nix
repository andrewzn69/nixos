{ config, pkgs, ... }:

{
  users.users.zemn = {
    isNormalUser = true;
    description = "Zemn";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };
}
