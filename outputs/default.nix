{ self, darwin, nixpkgs, home-manager, flake-utils, devenv, ... }@inputs:
let
  username = "diomedet";
  useremail = "diomede.tripicchio@gmail.com";
  system = "aarch64-darwin";
  hostname = "Applin";

  specialArgs = inputs // { inherit username useremail hostname; };

  # Configuration for `nixpkgs`
  nixpkgsConfig = rec {
    config = { allowUnfree = true; };
    #   overlays = [
    #     # (import ./overlays)
    #     # Make packages for other systems available for cross compilation
    #     (_: _:
    #       flake-utils.lib.eachDefaultSystem (system: {
    #         cross = import nixpkgs { inherit system config overlays; };
    #       }))
    #   ];
  };
  # pkgs = nixpkgs.legacyPackages.${system};
  # frameworks = pkgs.darwin.apple_sdk.frameworks;
in {
  darwinConfigurations."${hostname}" = darwin.lib.darwinSystem {
    inherit system specialArgs;
    # modules = commonDarwinConfig
    #   ++ [ ({ ... }: { networking.hostName = hostname; }) ];

    modules = [
      # Main `nix-darwin` config
      ../modules/host-users.nix
      ../modules/system.nix
      ../modules/nix-core.nix
      ../modules/nix-distributedBuilds.nix
      ../modules/apps.nix

      # `home-manager` module
      home-manager.darwinModules.home-manager
      {
        nixpkgs = nixpkgsConfig;

        # `home-manager` config
        # needed for the packages.nix file
        home-manager.extraSpecialArgs = specialArgs;
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;

        home-manager.users.${username} = import ../home;

        users.users.root.home = "/var/root";
        home-manager.users.root = import ../modules/home-manager/root.nix;
      }
    ];
  };

  formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;
}
