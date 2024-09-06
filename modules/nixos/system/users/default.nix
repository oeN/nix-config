# User setup
{
  self,
  config,
  lib,
  pkgs,
  ...
}: let
  keys = import "${self}/keys";
  secrets = config.age.secrets;
  cfg = config.my.system.users;
  groupExists = grp: builtins.hasAttr grp config.users.groups;
  groupsIfExist = builtins.filter groupExists;
in {
  options.my.system.users = with lib; {
    enable = my.mkDisableOption "user configuration";
  };

  config = lib.mkIf cfg.enable {
    users = {
      mutableUsers = false; # I want it to be declarative.

      users = {
        root = {
          hashedPasswordFile = secrets."users/root/hashed-password".path;
          openssh.authorizedKeys.keys = keys.users;
        };

        ${config.my.user.name} = {
          hashedPasswordFile = secrets."users/${config.my.user.name}/hashed-password".path;
          description = config.my.user.fullName;
          isNormalUser = true;
          shell = pkgs.zsh;
          extraGroups = groupsIfExist [
            "audio" # sound control
            "docker" # usage of `docker` socket
            "media" # access to media files
            "networkmanager" # wireless configuration
            "plugdev" # usage of ZSA keyboard tools
            "podman" # usage of `podman` socket
            "video" # screen control
            "wheel" # `sudo` for the user.
          ];
          openssh.authorizedKeys.keys = keys.users;
        };
      };
    };
  };
}
