{ ... }:

{
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/68551f1e-8b5c-4bed-8f56-fbbd337a5732";
    fsType = "ext4";
  };

  swapDevices = [
    {
      device = "/swapfile";
      size = 4096;
    }
  ];
}
