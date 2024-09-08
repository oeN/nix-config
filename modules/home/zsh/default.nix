{
  config,
  lib,
  system,
  my-user,
  ...
}: let
  cfg = config.my.home.zsh;
in {
  options.my.home.zsh = with lib; {
    enable = my.mkDisableOption "zsh configuration";
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
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
    }

    (lib.mkIf (system == "aarch64-darwin") {
      programs.zsh = {
        initExtra = ''
          source /Users/${my-user.name}/.config/op/plugins.sh
          export PATH="/opt/homebrew/opt/ruby/bin:/opt/homebrew/lib/ruby/gems/3.2.0/bin:$PATH"
          export LC_ALL=en_US.UTF-8
        '';
      };
    })
  ]);
}
