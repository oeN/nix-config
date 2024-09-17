{
  config,
  lib,
  ...
}: let
  secrets = config.age.secrets;
in {
  my.services = {
    # ssh-server = {
    #   enable = true;
    # };
    cachix = {
      enable = true;
    };
    backup = {
      enable = true;
      repository = "s3:https://s3.fr-par.scw.cloud/scyther-backups";
      # Backup every 6 hours
      timerConfig = {
        OnActiveSec = "6h";
        OnUnitActiveSec = "6h";
      };
      passwordFile = secrets."backup/password".path;
      credentialsFile = secrets."scaleway-credentials".path;
    };
    # monitoring = {
    #   enable = true;
    #   grafana = {
    #     passwordFile = secrets."monitoring/password".path;
    #     secretKeyFile = secrets."monitoring/secret-key".path;
    #   };
    # };
    # calibre-web = {
    #   enable = false;
    #   libraryPath = "/mnt/books";
    # };
    # nginx = {
    #   enable = true;
    #   monitoring.enable = true;
    #   acme = {
    #     wildcardDomain = "hl.diomedet.com";
    #     credentialsFile = secrets."route53/credentials".path;
    #   };
    #   sso = {
    #     authKeyFile = secrets."nginx/sso/auth-key".path;
    #     users = {
    #       diomedet = {
    #         passwordHashFile =
    #           secrets."nginx/sso/users/diomedet/password-hash".path;
    #       };
    #     };
    #     groups = {root = ["diomedet"];};
    #   };
    # };
    # postgresql-backup.enable = true;
    # # todo app
    # vikunja = {enable = true;};
    # # vpn
    # # wireguard = {
    # #   enable = true;
    # #   startAtBoot = true;
    # #   dns = {additionalServers = ["10.10.20.154" "1.1.1.1"];};
    # # };
    # navidrome = {
    #   enable = true;
    #   musicFolder = "/mnt/music";
    # };
    # pirate = {enable = true;};
  };
}
