{
  my,
  ...
}: {
  home.homeDirectory = "/home/${my.vars.username}";
  imports =
    (my.lib.scanPaths ./.)
    ++ [
      ../base/home.nix
    ];
}
