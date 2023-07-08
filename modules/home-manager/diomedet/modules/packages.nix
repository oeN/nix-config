{ pkgs, ... }: {
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

    # messaging
    slack
    teams
    discord

    obsidian
    nixfmt
  ];
}
