{ ... }:

{
  disko.devices.disk.main = {
    type = "disk";
    # partition made by sgdisk in the free space, the gpt is shared with macos
    device = "/dev/disk/by-partlabel/nixos";
    destroy = false;
    content = {
      type = "luks";
      name = "cryptroot";
      settings.allowDiscards = true;
      content = {
        type = "btrfs";
        extraArgs = [ "-f" ];
        subvolumes = {
          "/root" = {
            mountpoint = "/";
            mountOptions = [
              "compress=zstd"
              "noatime"
            ];
          };
          "/home" = {
            mountpoint = "/home";
            mountOptions = [
              "compress=zstd"
              "noatime"
            ];
          };
          "/nix" = {
            mountpoint = "/nix";
            mountOptions = [
              "compress=zstd"
              "noatime"
            ];
          };
        };
      };
    };
  };

  # esp made by the asahi installer, kept out of disko so it is never formatted
  fileSystems."/boot" = {
    device = "/dev/disk/by-partuuid/60a9373a-3b96-45fa-8a05-2075188b1b49";
    fsType = "vfat";
    options = [ "umask=0077" ];
  };
}
