{
  self,
  pkgs,
  ...
}: {
  imports = [
    ../../../base/fonts
  ];
  # all fonts are linked to /nix/var/nix/profiles/system/sw/share/X11/fonts
  fonts = {
    # use fonts specified by user rather than default ones
    enableDefaultPackages = false;
    fontDir.enable = true;

    # user defined fonts
    fontconfig.defaultFonts = {
      monospace = ["JetBrainsMono Nerd Font"];
    };
  };
}
