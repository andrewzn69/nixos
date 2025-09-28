{ config, pkgs, ... }:

{
  users.user.zemn = {
    isNormalUser = true;
    description = "Zemn";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };
}
