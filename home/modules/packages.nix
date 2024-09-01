{ pkgs, devenv, my-nixvim, ... }: {
  home.packages = with pkgs; [
    coreutils
    curl
    wget

    jq
    yq
    awscli2
    docker
    gh

    # utilties
    rectangle
    prom2json

    # messaging
    slack
    discord

    obsidian

    devenv.packages.${system}.devenv
    cachix

    ripgrep
    nodejs

    bacon
    libiconv
    rustup

    gcc

    lazygit

    dotnet-sdk

    my-nixvim.packages.${system}.default
  ];
}
