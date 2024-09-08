{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.home.rectangle;
in {
  options.my.home.rectangle = with lib; {
    enable = mkEnableOption "rectangle OSX utitlity configuration";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      # utilties
      rectangle
    ];
  };
}
