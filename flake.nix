{
  description = "zemn's nixos config"

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable;
  };

  outputs = { self, nixpkgs, ... }: {
    nixosConfigurations = {
      dev = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
	modules = [
	  ./hosts/dev/configuration.nix
	];
      };
    };
  };
}
