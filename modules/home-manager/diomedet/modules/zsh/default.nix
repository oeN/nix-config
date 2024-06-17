{ pkgs, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
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
      love = "~/Applications/love.app/Contents/MacOS/love";
    };
    initExtra = ''
      source /Users/diomedet/.config/op/plugins.sh
      export PATH="/opt/homebrew/opt/ruby/bin:/opt/homebrew/lib/ruby/gems/3.2.0/bin:$PATH"
      export LC_ALL=en_US.UTF-8
    '';
  };
}
