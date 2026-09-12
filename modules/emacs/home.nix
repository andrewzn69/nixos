{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
  };

  services.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
    client.enable = true;
    extraOptions = [ "--init-directory=${config.xdg.configHome}/emacs" ];
  };

  home.packages = with pkgs; [
    # doom core
    ripgrep
    fd
    coreutils
    gnutls

    # doom doctor
    imagemagick
    zstd
    sqlite
    editorconfig-core-c

    # :lang org
    graphviz
    pandoc

    # :term vterm builds a native module
    cmake
    gnumake
    libtool
  ];

  home.sessionPath = [ "${config.home.homeDirectory}/.config/emacs/bin" ];

  home.activation.doomConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ln -sfn ${config.home.homeDirectory}/.config/nixos/modules/emacs/doom ${config.home.homeDirectory}/.config/doom
  '';
}
