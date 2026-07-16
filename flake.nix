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
    nixcord.url = "github:kaylorben/nixcord";
    PolyMC.url = "github:PolyMC/PolyMC";
    user-agents = {
      url = "github:jnrbsn/user-agents";
      flake = false;
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
      nixcord,
      PolyMC,
      user-agents,
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
                  nixcord
                  user-agents
                  ;
              };
            }
          ];
        };
      };
    };
}
