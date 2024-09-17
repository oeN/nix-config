{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.homelab.nfs-mounts;
  smbOptions = [
    "x-systemd.automount"
    "noauto"
    "noserverino"
    "rw"
    #"guest"
    "username=media"
    "password=media"
    "file_mode=0775"
    "dir_mode=0775"
    #"uid=sonarr"
    "gid=media"
    "forcegid"
    #"forceuid"
    #"noperm"
  ];
in {
  options.my.homelab.nfs-mounts = with lib; {
    enable = mkEnableOption "mount NFS shares for the homelab";
  };

  config = lib.mkIf cfg.enable {
    # we need to enable extra-hosts to resolve the hostnames
    my.homelab.extra-hosts.enable = true;

    environment.systemPackages = [pkgs.cifs-utils];

    fileSystems = {
      "/mnt/books" = {
        device = "//amarcord/Media/Books";
        fsType = "cifs";
        options = smbOptions;
      };

      "/mnt/music" = {
        device = "//amarcord/Media/Music";
        fsType = "cifs";
        options = smbOptions;
      };

      "/mnt/media" = {
        device = "//amarcord/Media";
        fsType = "cifs";
        options = smbOptions;
      };

      "/mnt/downloads" = {
        device = "//amarcord/Downloads";
        fsType = "cifs";
        options = smbOptions;
      };
    };
  };
}
