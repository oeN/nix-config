{my, ...}: {
  programs.zsh = {
    initExtra = ''
      source /Users/${my.var.username}/.config/op/plugins.sh
      export PATH="/opt/homebrew/opt/ruby/bin:/opt/homebrew/lib/ruby/gems/3.2.0/bin:$PATH"
      export LC_ALL=en_US.UTF-8
    '';
  };

  home.shellAliases = {
    nixswitch = "darwin-rebuild switch --flake ~/nix-config/.#";
    love = "~/Applications/love.app/Contents/MacOS/love";
  };
}
