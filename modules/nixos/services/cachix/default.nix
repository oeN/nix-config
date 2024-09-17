{
  config,
  lib,
  ...
}: let
  cfg = config.my.services.cachix;
in {
  options.my.services.cachix = {
    enable = lib.mkEnableOption "cachix configuration";
  };

  config = lib.mkIf cfg.enable {
    services.cachix-agent.enable = true;
  };
}
