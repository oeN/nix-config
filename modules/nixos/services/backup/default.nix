{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.my.services.backup;
  secrets = config.age.secrets;
  excludeArg = with builtins;
  with pkgs;
    "--exclude-file="
    + (writeText "excludes.txt" (concatStringsSep "\n" cfg.exclude));
in {
  options.my.services.backup = with lib; {
    enable = mkEnableOption "Enable backups for this host";

    repository = mkOption {
      type = types.str;
      example = "/mnt/backup-hdd";
      description = "The repository to back up to";
    };

    paths = mkOption {
      type = with types; listOf str;
      default = [];
      example = ["/var/lib" "/home"];
      description = "Paths to backup";
    };

    passwordFile = mkOption {
      type = types.str;
      example = "/var/lib/restic/password.txt";
      description = "Read the repository's password from this path";
    };

    credentialsFile = mkOption {
      type = types.str;
      example = "/var/lib/restic/creds.env";
      description = ''
        Credential file as an 'EnvironmentFile' (see `systemd.exec(5)`)
      '';
    };

    exclude = mkOption {
      type = with types; listOf str;
      default = [];
      example = [
        # very large paths
        "/var/lib/docker"
        "/var/lib/systemd"
        "/var/lib/libvirt"

        # temporary files created by `cargo` and `go build`
        "**/target"
        "/home/*/go/bin"
        "/home/*/go/pkg"
      ];
      description = "Paths to exclude from backup";
    };

    pruneOpts = mkOption {
      type = with types; listOf str;
      default = [
        "--keep-last 10"
        "--keep-hourly 24"
        "--keep-daily 7"
        "--keep-weekly 5"
        "--keep-monthly 12"
        "--keep-yearly 100"
      ];
      example = ["--keep-last 5" "--keep-weekly 2"];
      description = ''
        List of options to give to the `forget` subcommand after a backup.
      '';
    };

    timerConfig = mkOption {
      # NOTE: I do not know how to cleanly set the type
      default = {OnCalendar = "daily";};
      example = {
        OnCalendar = "00:05";
        RandomizedDelaySec = "5h";
      };
      description = ''
        When to run the backup. See man systemd.timer for details.
      '';
    };
  };

  # TODO: improve me and make me more generic
  config = lib.mkIf cfg.enable {
    services.restic.backups.scaleway = {
      extraBackupArgs =
        ["--verbose=2"]
        ++ lib.optional (builtins.length cfg.exclude != 0) excludeArg;
      initialize = true;

      environmentFile = cfg.credentialsFile;

      paths = cfg.paths;

      inherit (cfg) passwordFile pruneOpts timerConfig repository;
    };
  };
}
