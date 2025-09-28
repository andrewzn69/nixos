{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  
  services.openssh.enable = true;

  # vm-specific services
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;
}
