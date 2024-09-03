{
  # NOTE: the args not used in this file CAN NOT be removed!
  # because haumea pass argument lazily,
  # and these arguments are used in the functions like `mylib.nixosSystem`, `mylib.colmenaSystem`, etc.
  inputs,
  lib,
  myvars,
  mylib,
  system,
  genSpecialArgs,
  ...
} @ args: let
  name = "umbreon";
  base-modules = {
    nixos-modules = map mylib.relativeToRoot [
      # common
      "modules/nixos/desktop.nix"
      # host specific
      "hosts/linux-${name}"
    ];
    home-modules = map mylib.relativeToRoot [
      # common
      "home/linux"
      # host specific
      # "hosts/linux-${name}/home.nix"
    ];
  };
in {
  nixosConfigurations = {
    "${name}" = mylib.nixosSystem (base-modules // args);
  };

  # generate iso image for hosts with desktop environment
  packages = {
    "${name}" = inputs.self.nixosConfigurations."${name}".config.formats.iso;
  };
}
