{
  config,
  lib,
  ...
}: let
  secrets = config.age.secrets;
in {
  my.homelab = {
    nfs-mounts = {
      enable = true;
    };
  };
}
