{
  flake-parts,
  systems,
  ...
} @ inputs: let
  mySystems = import systems;
  # inherit (inputs.nixpkgs) lib;
  # keys = import ../keys;
  # my = {
  #   keys = keys;
  #   lib = import ../lib {inherit lib;};
  #   vars = import ../vars {inherit lib keys;};
  # };
  # # Add my custom lib, vars, nixpkgs instance, and all the inputs to specialArgs,
  # # so that I can use them in all my nixos/home-manager/darwin modules.
  # # FIXME: I don't understand why I need to do this, but it works.
  # genSpecialArgs = system:
  #   inputs
  #   // {
  #     inherit my;
  #   };
  # args = {inherit inputs lib my genSpecialArgs;};
  # nixosSystems = {
  #   x86_64-linux = import ./x86_64-linux (args // {system = "x86_64-linux";});
  # };
  # darwinSystems = {
  #   aarch64-darwin = import ./aarch64-darwin (args // {system = "aarch64-darwin";});
  # };
  # allSystems = nixosSystems // darwinSystems;
  # allSystemNames = builtins.attrNames allSystems;
  # nixosSystemValues = builtins.attrValues nixosSystems;
  # darwinSystemValues = builtins.attrValues darwinSystems;
  # allSystemValues = nixosSystemValues ++ darwinSystemValues;
  # # Helper function to generate a set of attributes for each system
  # forAllSystems = func: (nixpkgs.lib.genAttrs allSystemNames func);
in
  flake-parts.lib.mkFlake {inherit inputs;} {
    systems = mySystems;

    imports = [
      ./checks.nix
      ./formatter.nix
      ./lib.nix
      ./nixos.nix
      ./darwin.nix
    ];

    # Add attribute sets into outputs, for debugging
    # debugAttrs = {inherit nixosSystems darwinSystems allSystems allSystemNames my;};

    # # NixOS Hosts
    # nixosConfigurations =
    #   lib.attrsets.mergeAttrsList (map (it: it.nixosConfigurations or {}) nixosSystemValues);

    # # macOS Hosts
    # darwinConfigurations =
    #   lib.attrsets.mergeAttrsList (map (it: it.darwinConfigurations or {}) darwinSystemValues);

    # # Development Shells
    # devShells = forAllSystems (
    #   system: let
    #     pkgs = nixpkgs.legacyPackages.${system};
    #   in {
    #     default = pkgs.mkShell {
    #       packages = with pkgs; [
    #         # fix https://discourse.nixos.org/t/non-interactive-bash-errors-from-flake-nix-mkshell/33310
    #         bashInteractive
    #         # fix `cc` replaced by clang, which causes nvim-treesitter compilation error
    #         gcc
    #         # Nix-related
    #         alejandra
    #         deadnix
    #         statix
    #         # spell checker
    #         typos
    #         # code formatter
    #         nodePackages.prettier
    #       ];
    #       name = "dots";
    #     };
    #   }
    # );

    # # Format the nix code in this flake
    # formatter = forAllSystems (
    #   # alejandra is a nix formatter with a beautiful output
    #   system: nixpkgs.legacyPackages.${system}.alejandra
    # );
  }