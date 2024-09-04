{
  description = "oeN's NixOS and Mac configuration";

  inputs = {
    # Package sets
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    devenv.url = "github:cachix/devenv";

    flake-utils.url = "github:numtide/flake-utils";

    # Environment/system management
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-24.05-darwin";
    nix-darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    haumea = {
      url = "github:nix-community/haumea/v0.2.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # generate iso/qcow2/docker/... image from nixos configuration
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    my-nixvim.url = "github:oeN/nix-vim";
  };

  outputs = inputs: import ./outputs inputs;
}
