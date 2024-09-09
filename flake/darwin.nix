{
  self,
  inputs,
  lib,
  ...
}: let
  inherit (inputs) nix-darwin;

  defaultModules = [
    {
      # Let 'nixos-version --json' know about the Git revision
      system.configurationRevision = self.rev or "dirty";
    }
    {
      nixpkgs.overlays =
        (lib.attrValues self.overlays)
        ++ [
          inputs.nur.overlay
        ];
    }
    # Include generic settings
    "${self}/modules/darwin"
  ];

  buildHost = name: system:
    nix-darwin.lib.darwinSystem {
      # inputs.nixpkgs.config.allowUnfree = true;
      inherit system;
      modules =
        defaultModules
        ++ [
          # {
          #   nixpkgs = {
          #     pkgs = import nixpkgs-darwin {inherit system;};
          #     hostPlatform = system;
          #     # config = {
          #     #   allowAliases = true;
          #     #   allowUnfree = true;
          #     # };
          #   };
          # }
          "${self}/hosts/darwin/${name}"
        ];
      specialArgs = {
        # Use my extended lib in NixOS configuration
        inherit (self) lib;
        # Inject inputs to use them in global registry
        inherit inputs;
        inherit system;
      };
    };
in {
  flake.darwinConfigurations = lib.mapAttrs buildHost {
    Applin = "aarch64-darwin";
  };
}
