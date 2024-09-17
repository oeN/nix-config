{
  config,
  lib,
  ...
}: let
  cfg = config.my.homebrew.whatsapp;
in {
  config.homebrew = lib.mkIf cfg.enable {
    casks = ["whatsapp"];
  };
}
