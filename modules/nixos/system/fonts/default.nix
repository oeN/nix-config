{pkgs, ...}: {
  imports = [
    ../../../base/fonts
  ];
  # all fonts are linked to /nix/var/nix/profiles/system/sw/share/X11/fonts
  fonts = {
    packages = with pkgs; [
      # fonts
      helvetica-neue-lt-std
    ];
    # use fonts specified by user rather than default ones
    enableDefaultPackages = false;
    fontDir.enable = true;

    # user defined fonts
    fontconfig.defaultFonts = {
      monospace = ["JetBrainsMono Nerd Font"];
      sansSerif = ["Helvetica Neue LT Std"];
    };
  };
}
