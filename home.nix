

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

home.packages = with pkgs; [
	firefox
	jetbrains-mono
	nerdfonts
	waybar
	tree
	rofi-wayland
	hello
	hyprpaper
	hyprpicker
	gimp
	vlc
	audacity
	spotify
	spotifyd
	nwg-look
	glib
	font-awesome
	nerdfonts
	chromium
	p7zip
	wineWayland
	grc
	discord
	slurp
	grimblast
	playerctl
	waybar-mpris
	spotify-player
	vimgolf
	ncurses
	google-chrome
	thunderbird
	galculator
	virt-manager
	godot_4
	blender
	jdk
	ant
	mono
	w3m
	brave
	wl-clipboard
	libreoffice
	gnumake
	eww
	vbam
	gdb
	qimgv
	bc
	socat
	hyprland-workspaces
	uhk-udev-rules
	uhk-agent
	qbittorrent
	mcomix
	libnotify
	dunst
	yt-dlp
	brightnessctl
	xdotool
	neovim
	vimPlugins.lazy-nvim
	pyright
	lua-language-server
	lsof
	service-wrapper
	clang-tools
	neovide
];
gtk = {
	enable = true;
	theme = {
		name = "Graphite-Dark";
		package = pkgs.graphite-gtk-theme;
	};
};
}
