{
  self,
  inputs,
  lib,
  ...
}: let
  inherit (inputs) nixpkgs-darwin nix-darwin;

  defaultModules = [
    {
      # Let 'nixos-version --json' know about the Git revision
      system.configurationRevision = self.rev or "dirty";
    }
    {
      nixpkgs.pkgs = nixpkgs-darwin;
    }
    # Include generic settings
    "${self}/modules/darwin"
  ];

  buildHost = name: system:
    nix-darwin.lib.darwinSystem {
      inherit system;
      modules =
        defaultModules
        ++ [
          "${self}/hosts/darwin/${name}"
        ];
      specialArgs = {
        # Use my extended lib in NixOS configuration
        inherit (self) lib;
        # Inject inputs to use them in global registry
        inherit inputs;
      };
    };
in {
  flake.darwinConfigurations = lib.mapAttrs buildHost {
    Applin = "aarch64-darwin";
  };
}
