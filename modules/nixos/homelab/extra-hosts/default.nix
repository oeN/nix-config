{
  config,
  lib,
  ...
}: let
  cfg = config.my.homelab.extra-hosts;
in {
  options.my.homelab.extra-hosts = with lib; {
    enable = mkEnableOption "add the common extraHosts configuration for the homelab";
  };

  config = lib.mkIf cfg.enable {
    networking.extraHosts = ''
      10.5.0.100 amarcord
    '';
  };
}
