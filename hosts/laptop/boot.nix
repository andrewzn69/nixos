{ ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;

  # the display driver hides the strip beside the notch unless told to use the full panel
  boot.kernelParams = [ "appledrm.show_notch=1" ];
}
