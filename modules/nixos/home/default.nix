{
  config,
  inputs,
  lib,
  system,
  ...
}: let
  actualPath = ["home-manager" "users" config.my.user.name "my" "home"];
  aliasPath = ["my" "home"];

  cfg = config.my.user.home;
in {
  imports = [
    inputs.home-manager.nixosModules.home-manager # enable home-manager options
    (lib.mkAliasOptionModule aliasPath actualPath) # simplify setting home options
  ];

  config = lib.mkIf cfg.enable {
    home-manager = {
      # Not a fan of out-of-directory imports, but this is a good exception
      users.${config.my.user.name} = {
        imports = ["${inputs.self}/modules/home"];
        home.homeDirectory = lib.mkForce "/home/${config.my.user.name}";
      };

      # Nix Flakes compatibility
      useGlobalPkgs = true;
      useUserPackages = true;

      # Forward inputs to home-manager configuration
      extraSpecialArgs = {
        inherit inputs;
        inherit system;
        my-user = config.my.user;
      };
    };
  };
}
