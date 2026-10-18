{
  config,
  lib,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  services.xserver.videoDrivers = [ "amdgpu" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  audio.mic = "alsa_input.usb-Kingston_HyperX_QuadCast_S_4100-00.analog-stereo";

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
