{
  description = "zemn's nixos config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    claude-code-nix.url = "github:sadjow/claude-code-nix";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      claude-code-nix,
      home-manager,
      ...
    }:
    {
      nixosConfigurations = {
        dev = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit claude-code-nix; };
          modules = [
            ./hosts/dev/default.nix
          ];
        };

        desktop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit claude-code-nix; };
          modules = [
            ./hosts/desktop/default.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.zemn = import ./users/zemn/home.nix;
            }
          ];
        };
      };
    };
}
