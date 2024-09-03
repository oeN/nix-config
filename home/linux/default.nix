{
  mylib,
  myvars,
  ...
}: {
  home.homeDirectory = "/home/${myvars.username}";
  imports =
    (mylib.scanPaths ./.)
    ++ [
      ../base/home.nix
    ];
}
