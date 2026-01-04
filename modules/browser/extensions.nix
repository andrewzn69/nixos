{ firefox-addons, pkgs }:

let
  myExtensions = with firefox-addons.packages.${pkgs.system}; [
    ublock-origin
    dearrow
  ];
in
{
  packages = myExtensions;
  force = true;
}
