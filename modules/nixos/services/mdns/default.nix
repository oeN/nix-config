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
    enable = lib.my.mkDisableOption "mDNS using 'Avahi'";
  };

  config = lib.mkIf cfg.enable {
    services.avahi = {
      enable = true;
      nssmdns4 = true;
#      domainName = config.networking.domain;
      publish = {
        enable = true;
        domain = true;
        userServices = true;
      };
    };

    # allow for custom hostnames
#    system.nssDatabases.hosts = lib.mkForce [
#      "mdsn4"
#      "[NOTFOUND=return]"
#      "resolve"
#      "[!UNAVAIL=return]"
#      "files"
#      "myhostname"
#      "dns"
#    ];
#
#    # allow for custom domain names
#    environment.etc."mdns.allow".text = config.networking.domain;
  };
}
