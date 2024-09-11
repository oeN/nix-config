{lib, ...}: {
  # Do not import anything by default each module will be imported by the given
  # nixos or darwin specific module if needed.

  imports = [
    ./blender
  ];

  options.my = with lib; {
    user = {
      fullName = mkOption {
        type = types.str;
        default = "Diomede Tripicchio";
        example = "Bob Smith";
        description = "my full name";
      };

      name = mkOption {
        type = types.str;
        default = "diomedet";
        example = "bob";
        description = "my username";
      };

      email = mkOption {
        type = types.str;
        default = "diomede.tripicchio@gmail.com";
        example = "bob@example.com";
        description = "my email";
      };

      home = {
        enable = my.mkDisableOption "home-manager configuration";
      };
    };
  };
}
