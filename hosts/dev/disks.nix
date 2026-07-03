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

  # nfs
  services.rpcbind.enable = true;

  fileSystems."/home/zemn/docs/obsidian" = {
    device = "100.64.100.10:/storage/apps/obsidian";
    fsType = "nfs";
    options = [
      "x-systemd.automount"
      "noauto"
      "x-systemd.idle-timeout=600"
      "nfsvers=4"
      "rw"
    ];
  };
}
