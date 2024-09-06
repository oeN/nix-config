{my, ...}: {
  home.homeDirectory = "/Users/${my.vars.username}";
  imports =
    (my.lib.scanPaths ./.)
    ++ [
      ../base/home.nix
    ];
}
