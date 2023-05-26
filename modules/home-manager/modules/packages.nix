{ pkgs, ... }:
{
  home.packages = with pkgs; [
    coreutils
    curl
    wget

    jq
    yq
    awscli2

    # utilties
    rectangle

    # messaging
    slack
    teams

    obsidian
    discord
  ];
}
