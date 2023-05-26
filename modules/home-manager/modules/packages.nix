{ pkgs, ... }:
{
  home.packages = with pkgs; [
    coreutils
    curl
    wget

    jq
    yq
    awscli2
    docker
    docker-desktop

    # utilties
    rectangle

    # messaging
    slack
    teams
    discord

    obsidian
  ];
}
