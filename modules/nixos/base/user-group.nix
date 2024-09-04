{
  myvars,
  config,
  ...
}: {
  # Don't allow mutation of users outside the config.
  users.mutableUsers = false;

  users.groups = {
    "${myvars.username}" = {};
    docker = {};
    wireshark = {};
    # for android platform tools's udev rules
    adbusers = {};
    dialout = {};
    # for openocd (embedded system development)
    plugdev = {};
    # misc
    uinput = {};
  };

  users.users."${myvars.username}" = {
    # generated by `mkpasswd -m scrypt`
    home = "/home/${myvars.username}";
    initialHashedPassword = config.users.users."${myvars.username}".initialHashedPassword;
    isNormalUser = true;
    extraGroups = [
      myvars.username
      "users"
      "networkmanager"
      "wheel"
      "docker"
      "wireshark"
      "adbusers"
      "libvirtd"
    ];
  };

  # root's ssh key are mainly used for remote deployment
  users.users.root = {
    initialHashedPassword = config.users.users."${myvars.username}".initialHashedPassword;
    openssh.authorizedKeys.keys = config.users.users."${myvars.username}".openssh.authorizedKeys.keys;
  };
}
