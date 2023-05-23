{
  description = "oeN's darwin system";

  inputs = {
    # Package sets
    nixpkgs.url = github:NixOS/nixpkgs/nixpkgs-unstable;

    # Environment/system management
    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

  };

  outputs = { self, darwin, nixpkgs, home-manager, ... }@inputs:
  let 

    inherit (darwin.lib) darwinSystem;
    inherit (inputs.nixpkgs.lib) attrValues makeOverridable optionalAttrs singleton;

    # Configuration for `nixpkgs`
    nixpkgsConfig = {
      config = { allowUnfree = true; };
      overlays = [ (import ./overlays) ];
    }; 
  in
  {
    # My `nix-darwin` configs
      
    darwinConfigurations = rec {
      Applin = darwinSystem {
        system = "aarch64-darwin";
        modules =  [ 
          # Main `nix-darwin` config
          ./configuration.nix
          ./darwin/homebrew.nix
          # `home-manager` module
          home-manager.darwinModules.home-manager
          {
            nixpkgs = nixpkgsConfig;

            # `home-manager` config
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            users.users.diomedet.home = "/Users/diomedet";
            home-manager.users.diomedet = import ./home/diomedet.nix;
          }
        ];
      };
      Diomedes-Virtual-Machine = Applin;
      # Appletun = Applin.override {
      #   primaryUserDefaults.override {
      #     nixConfigDirectory = "/Volumes/T7/diomedet/.config/nixpkgs";
      #   }
      # }
    };
 };
}