{ ... }:

{
  fileSystems."/" = {
    device = "/dev/mapper/vg0-root";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/9E55-7A5A";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };

  fileSystems."/home" = {
    device = "/dev/mapper/vg0-home";
    fsType = "ext4";
  };

  fileSystems."/mnt/games" = {
    device = "/dev/disk/by-uuid/bc0ca251-2995-4832-be2c-8838b37dbe80";
    fsType = "ext4";
  };

  fileSystems."/mnt/games-nvme" = {
    device = "/dev/disk/by-uuid/8b5a7848-6ff4-4e48-8ab7-fda1a76bbcf5";
    fsType = "ext4";
  };

  fileSystems."/mnt/diskd" = {
    device = "/dev/disk/by-uuid/615136fb-d2d1-4f25-b7eb-9ab577c2a3b1";
    fsType = "ext4";
  };

  swapDevices = [
    { device = "/dev/mapper/vg0-swap"; }
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
