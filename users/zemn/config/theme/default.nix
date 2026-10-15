{ pkgs, ... }:

let
  # not packaged in nixpkgs
  mcmojave-cursors = pkgs.stdenvNoCC.mkDerivation {
    pname = "mcmojave-cursors";
    version = "0-unstable-2021-02-24";
    src = pkgs.fetchFromGitHub {
      owner = "vinceliuice";
      repo = "McMojave-cursors";
      rev = "7d0bfc1f91028191cdc220b87fd335a235ee4439";
      hash = "sha256-4YqSucpxA7jsuJ9aADjJfKRPgPR89oq2l0T1N28+GV0=";
    };
    installPhase = ''
      runHook preInstall
      mkdir -p $out/share/icons
      cp -r dist $out/share/icons/McMojave-cursors
      runHook postInstall
    '';
  };
in
{
  home.pointerCursor = {
    enable = true;
    name = "McMojave-cursors";
    package = mcmojave-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  gtk = {
    enable = true;

    theme = {
      name = "Gruvbox-Custom";
    };

    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };

    gtk4 = {
      theme = null;
      extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };
  };

  home.file = {
    ".local/share/themes/Gruvbox-Custom/gtk-3.0".source = ./gtk-themes/gtk-3.0;
    ".local/share/themes/Gruvbox-Custom/gtk-4.0".source = ./gtk-themes/gtk-4.0;
  };

  # qt apps to follow gtk theme
  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style.name = "adwaita-dark";
  };

  # set dark mode preference via dconf
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };
}
