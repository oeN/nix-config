{...}: {
  my = {
    # disable desktop environment, is disabled by default but I want to be explicit
    desktop = {
      enable = false;
    };

    system = {
      nm-applet = {
        enable = false;
      };
    };

    packages = {
      blender = {
        enable = false;
      };

      whatsapp = {
        enable = false;
      };
    };

    services = {
      ssh-server = {
        enable = true;
      };
    };

    home = {
      direnv = {
        enable = false;
      };

      gamedev = {
        enable = false;
      };

      gtk = {
        enable = false;
      };

      kitty = {
        enable = false;
      };

      vscode = {
        enable = false;
      };

      wezterm = {
        enable = false;
      };
    };
  };
}
