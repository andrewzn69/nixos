{ lib, pkgs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "ahci"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [
    "dm-snapshot"
    "amdgpu"
  ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];
  boot.initrd.luks.devices.cryptlvm = {
    device = "/dev/nvme0n1p2";
    preLVM = true;
  };
  boot.resumeDevice = "/dev/vg0/swap";
  boot.kernelParams = [ "resume=/dev/vg0/swap" ];
  boot.kernelPatches = [
    {
      name = "disable-nova";
      patch = null;
      structuredExtraConfig = with lib.kernel; {
        DRM_NOVA = lib.mkForce no;
      };
    }
  ];
}
