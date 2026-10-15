{
  lib,
  pkgs,
  apple-silicon,
  ...
}:

let
  # apple firmware is not redistributable, the asahi installer puts it on the esp
  firmware = pkgs.requireFile {
    name = "firmware.cpio";
    sha256 = "a64c69834413ae8d3f0d0a0fd1310d69dae89c867e4b82812f71d48ed93d7f2a";
    message = ''
      The Asahi peripheral firmware is missing from the nix store. Add it with
        sudo nix-store --add-fixed sha256 /boot/vendorfw/firmware.cpio
      Rerunning the Asahi installer changes the file, so the hash in hosts/laptop/hardware.nix has to be updated as well.
    '';
  };
  vendorfw = pkgs.linkFarm "asahi-vendorfw" [
    {
      name = "firmware.cpio";
      path = firmware;
    }
  ];
  kbdBacklightRule = ''
    ACTION=="add", SUBSYSTEM=="leds", KERNEL=="kbd_backlight", ATTR{brightness}="64"
  '';
in
{
  imports = [ apple-silicon.nixosModules.apple-silicon-support ];

  hardware.asahi.enable = true;
  hardware.asahi.peripheralFirmwareDirectory = vendorfw;
  # keeps the cpio out of garbage collection since rebuilds of the firmware pkg need it
  environment.etc."asahi/vendorfw".source = vendorfw;

  services.upower.enable = true;

  # keyboard backlight always on
  boot.initrd.availableKernelModules = [ "pwm_apple" ];
  boot.initrd.services.udev.rules = kbdBacklightRule;
  services.udev.extraRules = kbdBacklightRule;
  # stops systemd restoring the brightness saved at shutdown
  systemd.services."systemd-backlight@leds:kbd_backlight".enable = false;

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
