# Nix related settings
{
  config,
  inputs,
  lib,
  options,
  pkgs,
  ...
}: let
  cfg = config.my.system.nix;

  channels = lib.my.merge [
    {
      # Allow me to use my custom package using `nix run self#pkg`
      self = inputs.self;
      # Add NUR to run some packages that are only present there
      nur = inputs.nur;
      # Use pinned nixpkgs when using `nix run pkgs#<whatever>`
      pkgs = inputs.nixpkgs;
    }
    (lib.optionalAttrs cfg.inputs.overrideNixpkgs {
      # ... And with `nix run nixpkgs#<whatever>`
      nixpkgs = inputs.nixpkgs;
    })
  ];
in {
  options.my.system.nix = with lib; {
    enable = my.mkDisableOption "nix configuration";

    inputs = {
      link = my.mkDisableOption "link inputs to `/etc/nix/inputs/`";

      addToRegistry = my.mkDisableOption "add inputs and self to registry";

      addToNixPath = my.mkDisableOption "add inputs and self to nix path";

      overrideNixpkgs = my.mkDisableOption "point nixpkgs to pinned system version";
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      assertions = [
        {
          assertion = cfg.inputs.addToNixPath -> cfg.inputs.link;
          message = ''
            enabling `my.system.nix.inputs.addToNixPath` needs to have
            `my.system.nix.inputs.link = true`
          '';
        }
      ];
    }

    {
      nix = {
        package = pkgs.nix;

        settings = {
          experimental-features = ["nix-command" "flakes"];
          # Trusted users are equivalent to root, and might as well allow wheel
          trusted-users = ["root" "@wheel"];

          # The NixOS module adds the official Hydra cache by default
          # No need to use `extra-*` options.
          substituters = [
            "https://nix-community.cachix.org/"
            "https://devenv.cachix.org/"
          ];

          trusted-public-keys = [
            "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
            "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
          ];
        };
        gc = {
          automatic = lib.mkDefault true;
          dates = lib.mkDefault "weekly";
          options = lib.mkDefault "--delete-older-than 7d";
        };
      };
    }

    (lib.mkIf cfg.inputs.addToRegistry {
      nix.registry = let
        makeEntry = v: {flake = v;};
        makeEntries = lib.mapAttrs (lib.const makeEntry);
      in
        makeEntries channels;
    })

    (lib.mkIf cfg.inputs.link {
      environment.etc = let
        makeLink = n: v: {
          name = "nix/inputs/${n}";
          value = {source = v.outPath;};
        };
        makeLinks = lib.mapAttrs' makeLink;
      in
        makeLinks channels;
    })

    (lib.mkIf cfg.inputs.addToNixPath {
      nix.nixPath =
        [
          "/etc/nix/inputs"
        ]
        ++ options.nix.nixPath.default;
    })
  ]);
}
