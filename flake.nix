{
  description = "oeN's darwin system";

  inputs = {
    # Package sets
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-23.05-darwin";
    devenv.url = "github:cachix/devenv";

    flake-utils.url = "github:numtide/flake-utils";

    # Environment/system management
    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

  };

  nixConfig = {
    extra-trusted-public-keys =
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-substituters = "https://devenv.cachix.org";
  };

  outputs =
    { self, darwin, nixpkgs, home-manager, flake-utils, devenv, ... }@inputs:
    let

      inherit (darwin.lib) darwinSystem;

      defaultSystem = "aarch64-darwin";

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
          users.users.root.home = "/var/root";
          home-manager.users.root = import ./modules/home-manager/root.nix;
        }
      ];

      pkgs = nixpkgs;
    in {
      # My `nix-darwin` configs
      darwinConfigurations.Applin = darwinSystem rec {
        system = defaultSystem;
        modules = commonDarwinConfig
          ++ [ ({ ... }: { networking.hostName = "Applin"; }) ];
      };

      # Diomedes-Virtual-Machine = Applin;
      # Appletun = Applin.override {
      #   primaryUserDefaults.override {
      #     nixConfigDirectory = "/Volumes/T7/diomedet/.config/nixpkgs";
      #   }
      # }

      # devShells.${defaultSystem}.default = devenv.lib.mkShell {
      #   inherit inputs pkgs;
      #   modules = [
      #     ({ pkgs, ... }: {
      #       # This is your devenv configuration
      #       packages = [ pkgs.hello ];

      #       enterShell = ''
      #         hello
      #       '';

      #       processes.run.exec = "hello";
      #     })
      #   ];
      # };

      # perSystem = { config, pkgs, ... }: {
      #   devShells = {
      #     default = pkgs.mkShellNoCC {
      #       name = "NixOS-config";

      #       nativeBuildInputs = with pkgs; [
      #         gitAndTools.pre-commit
      #         nixpkgs-fmt
      #       ];

      #       shellHook = ''
      #         ${config.pre-commit.installationScript}
      #       '';
      #     };
      #   };
      # };
    };
}
