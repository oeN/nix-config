{pkgs, ...}: {
  gtk = {
    enable = true;

    theme = {
      package = pkgs.gnome-themes-extra;
      name = "Adwaita";
    };

    iconTheme = {
      package = pkgs.gnome-themes-extra;
      name = "Adwaita";
    };
  };

  home.pointerCursor = {
    package = pkgs.vimix-cursors;
    name = "Vimix-cursors";

    gtk.enable = true;
  };
}
