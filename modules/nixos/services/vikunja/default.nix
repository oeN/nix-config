# Todo and kanban app
{
  config,
  lib,
  ...
}: let
  cfg = config.my.services.vikunja;
  subdomain = "todo";
  vikunjaDomain = "${subdomain}.${config.networking.domain}";
  socketPath = "/run/vikunja/vikunja.socket";
in {
  options.my.services.vikunja = with lib; {
    enable = mkEnableOption "Vikunja todo app";

    mail = {
      enable = mkEnableOption {description = "mailer configuration";};

      configFile = mkOption {
        type = types.str;
        example = "/run/secrets/vikunja-mail-config.env";
        description = "Configuration for the mailer connection, using environment variables.";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    services.vikunja = {
      enable = true;

      frontendScheme = "https";
      frontendHostname = vikunjaDomain;

      database = {
        type = "postgres";
        user = "vikunja";
        database = "vikunja";
        host = "/run/postgresql";
      };

      settings = {
        service = {
          # Only allow registration of users through the CLI
          enableregistration = false;
          # Ues the host's timezone
          timezone = config.time.timeZone;
          # Use UNIX socket for serving the API
          unixsocket = socketPath;
          unixsocketmode = "0o660";
        };

        mailer = {enabled = cfg.mail.enable;};
      };

      environmentFiles = lib.optional cfg.mail.enable cfg.mail.configFile;
    };

    my.services.nginx.virtualHosts = [
      {
        subdomain = subdomain;
        socket = socketPath;
      }
    ];

    # # This is a weird setup
    # my.services.nginx.virtualHosts = [{
    #   inherit subdomain;
    #   # Serve the root for the web-ui
    #   root = config.services.vikunja.package-frontend;

    #   extraConfig = {
    #     locations = {
    #       "/" = { tryFiles = "try_files $uri $uri/ /"; };

    #       # Serve the API through a UNIX socket
    #       "~* ^/(api|dav|\\.well-known)/" = {
    #         proxyPass = "http://unix:${socketPath}";
    #         extraConfig = ''
    #           client_max_body_size 20M;
    #         '';
    #       };
    #     };
    #   };
    # }];

    systemd.services.vikunja = {
      serviceConfig = {
        # Use a system user to simplify using the CLI
        DynamicUser = lib.mkForce false;
        # Set the user for postgres authentication
        User = "vikunja";
        # Create /run/vikunja/ to serve the UNIX socket
        RuntimeDirectory = "vikunja";
      };
    };

    users.users.vikunja = {
      description = "Vikunja Service";
      group = "vikunja";
      isSystemUser = true;
    };
    users.groups.vikunja = {};

    # Allow nginx to access the UNIX socket
    users.users.nginx.extraGroups = ["vikunja"];

    services.postgresql = {
      enable = true;
      ensureDatabases = ["vikunja"];
      ensureUsers = [
        {
          name = "vikunja";
          # ensurePermissions = { "DATABASE vikunja" = "ALL PRIVILEGES"; };
        }
      ];
    };

    my.services.backup = {
      paths = [config.services.vikunja.settings.files.basepath];
    };
  };
}
