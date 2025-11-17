{ pkgs, ... }:

{
  users.users.zemn = {
    isNormalUser = true;
    description = "Zemn";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.fish;
  };
}
