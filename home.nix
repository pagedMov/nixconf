

{ config, pkgs, lib, ... }:

{
imports = [
	./hm-modules/machine-settings.nix
];
######################################
##### ENVIRONMENT INITIALIZATION #####
######################################
home.enableNixpkgsReleaseCheck = false;
home.stateVersion = "24.05";

fonts.fontconfig.enable = true;
nixpkgs.config.allowUnfree = true;

######################################
####### PROGRAM CONFIGURATIONS #######
######################################

home.file = {
	".nixalias".source = 					dotfiles/.nixalias;
	".bashrc".source = 						dotfiles/.bashrc;
	".config/hypr/hyprland.conf".source = 	dotfiles/hyprland.conf;
	".config/hypr/hyprpaper.conf".source = 	dotfiles/hyprpaper.conf;
	".config/kitty/kitty.conf".source = 	dotfiles/kitty.conf;
	".config/waybar/config".source = 		dotfiles/waybar.conf;
	".config/waybar/style.css".source = 	dotfiles/waybarstyle.css;
	".config/dunst/dunstrc".source = 		dotfiles/dunstrc;
	".config/nvim/init.lua".source =		dotfiles/nvim-init.lua;
	".config/neovide/init.lua".source =		dotfiles/nvim-init.lua;
};

gtk = {
	enable = true;
	theme = {
		name = "Graphite-Dark";
		package = pkgs.graphite-gtk-theme;
	};
};
}
