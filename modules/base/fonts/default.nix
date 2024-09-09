{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      # icon fonts
      material-design-icons
      font-awesome
      noto-fonts-color-emoji
      jetbrains-mono

      # nerdfonts
      # https://github.com/NixOS/nixpkgs/blob/nixos-24.05/pkgs/data/fonts/nerdfonts/shas.nix
      (nerdfonts.override {
        fonts = [
          # symbols icon only
          "NerdFontsSymbolsOnly"
          # Characters
          "FiraCode"
          "JetBrainsMono"
          "Iosevka"
          "FiraMono"
          "Meslo"
        ];
      })
      julia-mono
      dejavu_fonts
    ];
  };
}
