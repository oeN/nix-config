{
  config,
  lib,
  system,
  ...
}: let
  cfg = config.my.home.shell-aliases;
in {
  options.my.home.shell-aliases = with lib; {
    enable = my.mkDisableOption "shell aliases configuration";
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      home.shellAliases = {
        k = "kubectl";
        kx = "kubectx";
        dc = "docker-compose";
        d = "docker";

        nixup = "pushd ~/nix-config; nix flake update; nixswitch; popd";
      };
    }

    (lib.mkIf (system == "x86_64-linux") {
      home.shellAliases = {
        nixswitch = "sudo nixos-rebuild switch --flake ~/nix-config/.#";
      };
    })

    (lib.mkIf (system == "aarch64-darwin") {
      home.shellAliases = {
        nixswitch = "darwin-rebuild switch --flake ~/nix-config/.#";
        love = "~/Applications/love.app/Contents/MacOS/love";
      };
    })
  ]);
}
