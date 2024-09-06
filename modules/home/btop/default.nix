{
  config,
  lib,
  ...
}: let
  cfg = config.my.home.btop;
in {
  options.my.home.btop = with lib; {
    enable = my.mkDisableOption "btop configuration";
  };

  config.programs.btop = lib.mkIf cfg.enable {
    enable = true;
  };
}
