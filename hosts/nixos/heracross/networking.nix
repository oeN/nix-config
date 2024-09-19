{lib, ...}: let
  homelabPrivateIp = "10.5.0.114";
  localNetworkIp = "10.10.5.114";
  nameservers = ["10.10.20.154" "8.8.8.8"];
  defaultGatewayIp = "10.10.20.2";
  hostname = "heracross";
  domain = "local";
in {
  networking = {
    hostName = hostname;
    domain = domain;
    nameservers = nameservers;

    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    useDHCP = false;

    defaultGateway = {
      address = defaultGatewayIp;
      interface = "ens18";
    };

    interfaces = {
      ens18 = {
        useDHCP = lib.mkDefault false;
        ipv4 = {
          addresses = [
            {
              address = localNetworkIp;
              prefixLength = 16;
            }
          ];
        };
      };
      ens19 = {
        ipv4 = {
          addresses = [
            {
              address = homelabPrivateIp;
              prefixLength = 24;
            }
          ];
        };
      };
    };
  };

  # my.hardware.networking = {
  #   # Which interface is used to connect to the internet
  #   externalInterface = "wlp0s20f3";

  #   # Enable WiFi integration
  #   wireless.enable = true;
  # };
}
