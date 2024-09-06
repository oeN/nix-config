# Network discovery, mDNS with Avahi
# With this enabled, you can access your machine at <hostname>.local
# it's more convenient than using the IP address.
# https://avahi.org/
{
  config,
  lib,
  ...
}: let
  cfg = config.my.services.mdns;
in {
  options.my.services.mdns = {
    enable = lib.mkDisableOption "mDNS using 'Avahi'";
  };

  config = lib.mkIf cfg.enable {
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      publish = {
        enable = true;
        domain = true;
        userServices = true;
      };
    };
  };
}
