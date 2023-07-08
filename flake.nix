{
  description = "oeN's darwin system";

  inputs = {
    # Package sets
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    flake-utils.url = "github:numtide/flake-utils";

    # Environment/system management
    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

  };

  outputs = { self, darwin, nixpkgs, home-manager, flake-utils, ... }@inputs:
    let

      inherit (darwin.lib) darwinSystem;

      # Configuration for `nixpkgs`
      nixpkgsConfig = rec {
        config = { allowUnfree = true; };
        overlays = [
          (import ./overlays)
          # Make packages for other systems available for cross compilation
          (_: _:
            flake-utils.lib.eachDefaultSystem (system: {
              cross = import nixpkgs { inherit system config overlays; };
            }))
        ];
      };

      commonDarwinConfig = [
        # Main `nix-darwin` config
        ./modules/darwin
        ./modules/darwin/homebrew.nix

        # `home-manager` module
        home-manager.darwinModules.home-manager
        {
          nixpkgs = nixpkgsConfig;

          # `home-manager` config
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          users.users.diomedet.home = "/Users/diomedet";
          home-manager.users.diomedet = import ./modules/home-manager/diomedet;
          home-manager.users.root = import ./modules/home-manager/root.nix;
        }
      ];
    in {
      # My `nix-darwin` configs
      darwinConfigurations.Applin = darwinSystem rec {
        system = "aarch64-darwin";
        modules = commonDarwinConfig
          ++ [ ({ ... }: { networking.hostName = "Applin"; }) ];
      };

      # Diomedes-Virtual-Machine = Applin;
      # Appletun = Applin.override {
      #   primaryUserDefaults.override {
      #     nixConfigDirectory = "/Volumes/T7/diomedet/.config/nixpkgs";
      #   }
      # }
    };
}
