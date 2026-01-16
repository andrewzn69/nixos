{ ... }:

{
  # nix settings
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowUnfree = true;

  # locale
  time.timeZone = "Europe/Prague";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "cs_CZ.UTF-8";
      LC_IDENTIFICATION = "cs_CZ.UTF-8";
      LC_MEASUREMENT = "cs_CZ.UTF-8";
      LC_MONETARY = "cs_CZ.UTF-8";
      LC_NAME = "cs_CZ.UTF-8";
      LC_NUMERIC = "cs_CZ.UTF-8";
      LC_PAPER = "cs_CZ.UTF-8";
      LC_TELEPHONE = "cs_CZ.UTF-8";
      LC_TIME = "cs_CZ.UTF-8";
    };
  };

  # env
  environment.sessionVariables = {
    TERMINAL = "xterm";
    VISUAL = "nvim";
    EDITOR = "nvim";
    MANPAGER = "nvim +Man!";

    # pfetch
    PF_INFO = "ascii title os uptime pkgs";
    PF_COL1 = "7";
    PF_COL3 = "5";

    # xdg
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_CACHE_HOME = "$HOME/.cache";

    # claude
    ANTHROPIC_MODEL = "claude-sonnet-4-5-20250929";

    # ???
    ANSIBLE_NOCOWS = "1";
  };

  # services
  services.openssh.enable = true;
}
