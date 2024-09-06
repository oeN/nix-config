# Enable the node exporter for the host with Prometheus
{
  config,
  lib,
  ...
}: let
  cfg = config.my.services.host-monitor;
in {
  options.my.services.host-monitor = {
    enable = lib.mkEnableOption "Enable the node exporter for the host with Prometheus";
  };

  config = lib.mkIf cfg.enable {
    services.prometheus.exporters.node = {
      enable = true;
      listenAddress = "0.0.0.0";
      port = 9100;
      # There're already a lot of collectors enabled by default
      # https://github.com/prometheus/node_exporter?tab=readme-ov-file#enabled-by-default
      enabledCollectors = [
        "systemd"
        "logind"
      ];

      # use either enabledCollectors or disabledCollectors
      # disabledCollectors = [];
    };
  };
}
