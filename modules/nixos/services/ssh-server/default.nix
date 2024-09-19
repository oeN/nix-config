# An SSH server, using 'mosh'
{
  config,
  lib,
  ...
}: let
  cfg = config.my.services.ssh-server;
in {
  options.my.services.ssh-server = {
    enable = lib.mkEnableOption "SSH Server using 'mosh'";
  };

  config = lib.mkIf cfg.enable {
    services.openssh = {
      # Enable the OpenSSH daemon.
      enable = true;

      settings = {
        # temporary allow root login
        PermitRootLogin = "yes";
        PasswordAuthentication = false;
      };
    };

    # Opens the relevant UDP ports.
    programs.mosh.enable = true;
  };
}
