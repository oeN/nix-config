{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "jump" "aws" "kubectl" ];
    };
    shellAliases = {
      nixswitch = "darwin-rebuild switch --flake ~/nix-config/.#";
      nixup = "pushd ~/nix-config; nix flake update; nixswitch; popd";
      k = "kubectl";
      kx = "kubectx";
      dc = "docker-compose";
      d = "docker";
    };
  };
}
