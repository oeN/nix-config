{
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    love # Love2D game engine
  ];
}
