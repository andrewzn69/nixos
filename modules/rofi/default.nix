{
  pkgs,
  config,
  lib,
  ...
}:

let
  inherit (config.lib.formats.rasi) mkLiteral;
  theme = import ./config/theme.nix { inherit mkLiteral; };

  drunTheme = import ./config/drun.nix { inherit mkLiteral theme; };
  powermenuTheme = import ./config/powermenu.nix { inherit mkLiteral theme; };

  powermenuScript = import ./config/scripts/powermenu.nix { inherit pkgs; };

  # custom toRasi generator (converts nix attrs to .rasi format)
  mkValueString =
    v:
    if builtins.isBool v then
      (if v then "true" else "false")
    else if builtins.isInt v then
      toString v
    else if (v ? _type && v._type == "literal") then
      v.value
    else if builtins.isString v then
      ''"${v}"''
    else if builtins.isList v then
      "[ ${lib.concatMapStringsSep ", " mkValueString v} ]"
    else
      abort "Unsupported type: ${builtins.typeOf v}";

  mkKeyValue = k: v: "${k}: ${mkValueString v};";

  mkRasiSection =
    name: value:
    if builtins.isAttrs value then
      "${name} {\n${
        lib.concatStringsSep "\n" (
          lib.mapAttrsToList (k: v: "  ${mkKeyValue k v}") (lib.filterAttrs (_: v: v != null) value)
        )
      }\n}"
    else
      mkKeyValue name value;

  toRasi = attrs: lib.concatStringsSep "\n\n" (lib.mapAttrsToList mkRasiSection attrs);
in
{
  programs.rofi = {
    enable = true;
    plugins = [ pkgs.rofi-emoji ]; # emoji picker plugin
    theme = drunTheme;

    extraConfig = {
      modi = "drun";
      show-icons = true;
      display-drun = "󰍉";
      drun-display-format = "{name} [({exec})]";
    };
  };

  home.file = {
    # generate powermenu.rasi from nix attrs
    ".config/rofi/powermenu.rasi".text = toRasi powermenuTheme;

    # install powermenu script
    ".config/rofi/scripts/powermenu.sh".source = powermenuScript;
  };
}
