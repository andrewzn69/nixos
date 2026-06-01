{
  lib,
  config,
  pkgs,
  ...
}:

let
  shellPackages = {
    fish = pkgs.fish;
    zsh = pkgs.zsh;
  };
in
{
  imports = [
    ./fish.nix
    ./zsh.nix
  ];

  options.shells = lib.mkOption {
    type = lib.types.listOf (lib.types.enum (builtins.attrNames shellPackages));
    default = [ ];
  };

  config = {
    users.users = lib.mapAttrs (user: hmCfg: {
      shell = shellPackages.${hmCfg.shell.default};
    }) config.home-manager.users;

    home-manager.sharedModules = [
      {
        options.shell = {
          default = lib.mkOption {
            type = lib.types.enum (builtins.attrNames shellPackages);
            default = builtins.head (builtins.attrNames shellPackages);
          };
          enabled = lib.mkOption {
            type = lib.types.listOf (lib.types.enum (builtins.attrNames shellPackages));
            default = [ ];
          };
        };
      }
    ];
  };
}
