{
  description = "a minimal flake to test it on osx";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    darwinConfigurations.Applin = inputs.darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      pkgs = import inputs.nixpkgs { system = "aarch64-darwin"; };
      modules = [
        ({ pkgs, ... }: {
	  progams.zsh.enable = true;
	  environment.shells = [ pkgs.bash pkgs.zsh ];
	  environment.loginShell = pkgs.zsh;
	  environment.systemPackages = [ pkgs.coreutils ];
	  nix.extraOptions = ''
	    experimental-features = nix-command flakes
	  '';
	  system.keyboard.enableKeyMapping = true;
	  system.keyboard.remapCapsLockToEscape = true;
	  fonts.fontDir.enable = true;
	  fonts.fonts = 
	    [ (pkgs.nerdfonds.override { fonts = [ "Meslo" ]; }) ];
          services.nix-daemon.enable = true;
	  system.defaults.finder.AppleShowAllExtensions = true;
	  system.defaults.finder._FXShowPosixPathInTitle = true;
	  system.defaults.dock.autohide = true;
	  system.defaults.NSGlobalDomain.AppleShowAllExtensions = true;
	  system.defaults.NSGlobalDomain.InitialKeyRepeat = 14;
	  system.defaults.NSGlobalDomain.KeyRepeat = 1;
	  system.stateVersion = 4;
	})
	inputs.home-manager.darwinModule.home-manager {
	  home-manager = {
	    useGlobalPkgs = true;
	    useUserPackages = true;
	    users.diomedet.imports = [
	      ({ pkgs, ... }: {
	        home.stateVersion = "22.11";
		home.packages = [ pkgs.ripgrep pkgs.fd pkgs.curl pkgs.less ];
		home.sessionVariables = {
		  PAGER = "less";
		  CLICOLOR = 1;
		  EDITOR = "nvim";
		};
		programs.bat.enable = true;
		programs.bat.config.theme = "OneDark";
		programs.fzf.enable = true;
		programs.fzf.enableZshIntegration = true;
		programs.git.enable = true;
		programs.zsh.enable = true;
		programs.zsh.enableAutosuggetions = true;
		programs.zsh.enableSyntaxHighlighting = true;
		programs.starship.enable = true;
		programs.starship.enableZshIntegration = true;
		programs.alacritty = {
		  enable = true;
		  settings.font.normal.family = "MesloLGS Nerd Font Mono";
		  settings.font.size = 16;
		};
	      })
	    ];
	  };
	}
      ];
    };
  };
}
