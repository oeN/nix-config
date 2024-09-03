{...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = ["git" "jump" "aws" "kubectl"];
    };
  };

  home.shellAliases = {
    nixup = "pushd ~/nix-config; nix flake update; nixswitch; popd";
    k = "kubectl";
    kx = "kubectx";
    dc = "docker-compose";
    d = "docker";
  };
}
