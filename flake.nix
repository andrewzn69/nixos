{
  description = "zemn's nixos config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    claude-code-nix.url = "github:sadjow/claude-code-nix";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zorya.url = "github:andrewzn69/zorya-shell";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    PolyMC.url = "github:PolyMC/PolyMC";
    user-agents = {
      url = "github:jnrbsn/user-agents";
      flake = false;
    };
    apple-silicon = {
      url = "github:nix-community/nixos-apple-silicon";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      claude-code-nix,
      home-manager,
      zorya,
      zen-browser,
      firefox-addons,
      PolyMC,
      user-agents,
      apple-silicon,
      disko,
      ...
    }:
    {
      nixosConfigurations = {
        dev = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit claude-code-nix; };
          modules = [
            ./hosts/dev/default.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.zemn = import ./users/zemn/home-dev.nix;
            }
          ];
        };

        desktop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit claude-code-nix PolyMC; };
          modules = [
            ./hosts/desktop/default.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.zemn = import ./users/zemn/home-desktop.nix;
              home-manager.extraSpecialArgs = {
                inherit
                  zorya
                  zen-browser
                  firefox-addons
                  user-agents
                  ;
              };
            }
          ];
        };

        laptop = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          specialArgs = { inherit claude-code-nix; };
          modules = [
            apple-silicon.nixosModules.apple-silicon-support
            disko.nixosModules.disko
            ./hosts/laptop/default.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.zemn = import ./users/zemn/home-laptop.nix;
              home-manager.extraSpecialArgs = {
                inherit
                  zorya
                  zen-browser
                  firefox-addons
                  user-agents
                  ;
              };
            }
          ];
        };
      };
    };
}
