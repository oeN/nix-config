{
  pkgs,
  devenv,
  my-nixvim,
  ...
}: {
  home.packages = with pkgs; [
    coreutils

    jq
    yq
    awscli2
    docker
    gh
    neofetch

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
