# Language settings
{ config, lib, ... }:
let
  cfg = config.my.system.language;
in
{
  options.my.system.language = with lib; {
    enable = my.mkDisableOption "language configuration";

    locale = mkOption {
      type = types.str;
      default = "en_US.UTF-8";
      example = "en_US.UTF-8";
      description = "Which locale to use for the system";
    };

    extraLocale = mkOption {
      type = types.str;
      default = "it_IT.UTF-8";
      example = "it_IT.UTF-8";
      description = "Which locale to use for date, time, currency, etc.";
    };
  };

  config = lib.mkIf cfg.enable {
    # Select internationalisation properties.
    i18n.defaultLocale = cfg.locale;

    i18n.extraLocaleSettings = {
      LC_ADDRESS = cfg.extraLocale;
      LC_IDENTIFICATION = cfg.extraLocale;
      LC_MEASUREMENT = cfg.extraLocale;
      LC_MONETARY = cfg.extraLocale;
      LC_NAME = cfg.extraLocale;
      LC_NUMERIC = cfg.extraLocale;
      LC_PAPER = cfg.extraLocale;
      LC_TELEPHONE = cfg.extraLocale;
      LC_TIME = cfg.extraLocale;
    };
  };
}
