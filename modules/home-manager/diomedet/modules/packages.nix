{ pkgs, inputs, defaultSystem, ... }: {
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
    teams
    discord

    obsidian
    nixfmt

    inputs.devenv.packages.${defaultSystem}.devenv
    cachix

    ripgrep
    nodejs

    bacon
    libiconv
    rustup

    gcc

    lazygit

    dotnet-sdk
  ];

}
