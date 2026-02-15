{ ... }:

{
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = [ "zemn" ];
    };
    extraConfig = "AcceptEnv NVIM_THEME";
  };
}
