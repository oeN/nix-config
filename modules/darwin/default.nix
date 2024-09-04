{my, ...}: {
  imports =
    (my.lib.scanPaths ./.)
    ++ [
      ../base.nix
    ];
}
