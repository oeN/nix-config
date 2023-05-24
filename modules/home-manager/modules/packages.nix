{ pkgs, ... }:
{
  home.packages = with pkgs; [
    coreutils
    curl
    wget

    jq
    yq
    awscli2
    _1password
    _1password-gui

    # utilties
    rectangle

    # messaging
    slack
    teams
  ];
}