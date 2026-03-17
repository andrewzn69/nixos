{ ... }:

{
  services.rpcbind.enable = true;

  fileSystems."/home/zemn/docs/obsidian" = {
    device = "100.64.100.64:/storage/apps/obsidian";
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
