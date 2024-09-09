{
  lib,
  pkgs,
  ...
}: {
  imports = lib.attrValues (lib.my.mapModules ./. (file: file));
  ##########################################################################
  #
  #  Install all apps and packages here.
  #
  #  NOTE: Your can find all available options in:
  #    https://daiderd.com/nix-darwin/manual/index.html
  #
  ##########################################################################

  # Install packages from nix's official package repository.
  #
  # The packages installed here are available to all users, and are reproducible across machines, and are rollbackable.
  # But on macOS, it's less stable than homebrew.
  #
  # Related Discussion: https://discourse.nixos.org/t/darwin-again/29331

  # TODO: check if the my.home.zsh is enable and set the shell to zsh if it is.
  programs.zsh.enable = true;
  environment = {
    shells = [pkgs.zsh];
    variables.EDITOR = "nvim";
    systemPath = ["/opt/homebrew/bin" "/opt/homebrew/sbin"];

    systemPackages = with pkgs; [
      neovim
      git

      gnugrep
      gnutar

      gcc
      just # use Justfile to simplify nix-darwin's commands
    ];
  };
}
