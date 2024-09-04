{
  my,
  config,
  ...
}: {
  # Don't allow mutation of users outside the config.
  users.mutableUsers = false;

  users.groups = {
    "${my.vars.username}" = {};
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

  users.users."${my.vars.username}" = {
    # generated by `mkpasswd -m scrypt`
    inherit (my.vars) initialHashedPassword;
    home = "/home/${my.vars.username}";
    isNormalUser = true;
    extraGroups = [
      my.vars.username
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
    initialHashedPassword = config.users.users."${my.vars.username}".initialHashedPassword;
    openssh.authorizedKeys.keys = config.users.users."${my.vars.username}".openssh.authorizedKeys.keys;
  };
}
