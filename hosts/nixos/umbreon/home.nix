{pkgs, ...}: {
  my.home = {
    # Some amount of social life
    discord.enable = true;
    # Image viewver
    feh.enable = true;
    # Firefo profile and extensions
    firefox.enable = true;
    # Blue light filter
    gammastep.enable = true;
    # Machine specific packages
    packages.additionalPackages = with pkgs; [
      jellyfin-media-player # Wraps the webui and mpv together
    ];
    # Minimal video player
    mpv.enable = true;
    # Network-Manager applet
    nm-applet.enable = true;
  };
}
