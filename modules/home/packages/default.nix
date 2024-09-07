{
  config,
  lib,
  pkgs,
  inputs,
  system,
  ...
}: let
  cfg = config.my.home.packages;
  my-nixvim = inputs.my-nixvim;
  devenv = inputs.devenv;
in {
  options.my.home.packages = with lib; {
    enable = my.mkDisableOption "user packages";

    allowAliases = mkEnableOption "allow package aliases";

    allowUnfree = my.mkDisableOption "allow unfree packages";

    additionalPackages = mkOption {
      type = with types; listOf package;
      default = [];
      example = literalExample ''
        with pkgs; [
          quasselClient
        ]
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; ([
        fd
        file
        ripgrep
        obsidian
        neofetch

        coreutils

        jq
        yq
        awscli2
        docker
        gh

        # utilties
        prom2json

        # messaging
        slack
        discord

        cachix

        ripgrep
        nodejs

        bacon
        libiconv
        rustup

        gcc

        lazygit

        dotnet-sdk

        devenv.packages.${system}.default
        my-nixvim.packages.${system}.default
      ]
      ++ cfg.additionalPackages);

    nixpkgs.config = {
      inherit (cfg) allowAliases allowUnfree;
    };
  };
}
