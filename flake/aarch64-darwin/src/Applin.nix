{
  # NOTE: the args not used in this file CAN NOT be removed!
  # because haumea pass argument lazily,
  # and these arguments are used in the functions like `mylib.nixosSystem`, `mylib.colmenaSystem`, etc.
  inputs,
  lib,
  my,
  system,
  genSpecialArgs,
  ...
} @ args: let
  name = "Applin";

  modules = {
    darwin-modules =
      (map my.lib.relativeToRoot [
        # common
        "modules/darwin"
        # host specific
        "hosts/darwin-${name}"
      ])
      ++ [];
    home-modules = map my.lib.relativeToRoot [
      # "hosts/darwin-${name}/home.nix"
      "home/darwin"
    ];
  };

  systemArgs = modules // args;
in {
  # macOS's configuration
  darwinConfigurations.${name} = my.lib.macosSystem systemArgs;
}
