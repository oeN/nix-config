{...}: {
  my.home = {
    gtk = {
      enable = false;
    };

    # TODO: make it compatible with nix-darwin
    gamedev = {
      enable = false;
    };

    # nix = {
    #   inputs = {
    #     link = false;
    #     addToRegistry = false;
    #     addToNixPath = false;
    #     overrideNixpkgs = false;
    #   };
    # };
  };
}