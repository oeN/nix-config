{lib, ...}: {
  networking = {
    hostName = "umbreon";

    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    useDHCP = false;

    interfaces.enp0s31f6.useDHCP = lib.mkDefault true;
    interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;
  };

  my.hardware.networking = {
    # Which interface is used to connect to the internet
    externalInterface = "wlp0s20f3";

    # Enable WiFi integration
    wireless.enable = true;
  };
}
