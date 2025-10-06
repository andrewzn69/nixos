{ config, pkgs, ... }:

{
  environment.sessionVariables = {
    # programs
    TERMINAL = "xterm";
    # BROWSER = "firefox";
    VISUAL = "nvim";
    EDITOR = "nvim";
    MANPAGER = "nvim +Man!";

    # pfetch
    PF_INFO = "ascii title os uptime pkgs";
    # PF_ASCII = "Catppuccin";
    PF_COL1 = "7";
    PF_COL3 = "5";

    # xdg
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_CACHE_HOME = "$HOME/.cache";
    # XDG_DATA_HOME = "$HOME/.local/share";
    # XDG_STATE_HOME = "$HOME/.local/state";
    # XDG_CONFIG_DIRS = "/etc/xdg";
    # XDG_DATA_DIRS = "/usr/local/share:/usr/share:/var/lib/flatpak/exports/share:$XDG_DATA_HOME/flatpak/exports/share";
    # XDG_RUNTIME_DIR = "/run/user/$(id -u)"

    # removes background color for mounted directories, because it is fucking unreadable
    # LS_COLORS = "$LS_COLORS:ow=1;34:tw=1;34:";

    # why just why???
    ANSIBLE_NOCOWS = "1";
  };
}
