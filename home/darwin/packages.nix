{pkgs, ...}: {
  home.packages = with pkgs; [
    # utilties
    rectangle
  ];
}
