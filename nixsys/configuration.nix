
# Kyler Clay's NixOS configuration
# Make sure to install home-manager:
# sudo nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
# sudo nix-channel --update

# Note - this file is not meant to be edited lightly. This is meant to be the core configuration shared across many machines.
# If you wish to make changes to your current environment, use hardware-specific.nix in /etc/nixos/modules

{ config, lib, pkgs, ... }:
{
system.stateVersion = "24.05";
imports = [
	./hardware-configuration.nix
	./modules/hardware-specific.nix 
	./modules/issue.nix
];

boot.loader.systemd-boot.enable = true;
boot.loader.efi.canTouchEfiVariables = true;
nixpkgs.config.allowUnfree = true;
environment.systemPackages = with pkgs; [
	wget
	vim
	mkinitcpio-nfs-utils
	gawk
	kitty
	polkit
	inetutils
	less
	more
	rsync
	git
	docker
	alsa-utils
	neofetch
	findutils
	coreutils
	xorg.xhost
	sudo
	curl
	git
	bash
	bat
	eza
	jq
	curl
	unzip
	zip
	file
	gcc
	htop
	tree
	grc
	gnupg
	ranger
	ffmpeg
	openssh
	nmap
	dbus
	usbutils
	home-manager
	xdg-desktop-portal-hyprland
];

networking.networkmanager.enable = true;
networking.hostName = "HAUNTER";

time.timeZone = "America/New_York";

i18n.defaultLocale = "en_US.UTF-8";
console = {
	earlySetup = true;
	packages = with pkgs; [ terminus_font ];
	font = "Cyr_a8x14";
	useXkbConfig = true;
};

programs.hyprland.enable = true;
programs.dconf.enable = true;

services.xserver.xkb.layout = "us";
services.xserver.xkb.options = "eurosign:e,caps:escape";
services.openssh.enable = true;
services.printing.enable = true;
services.pipewire = {
	enable = true;
	pulse.enable = true;
};

nix.gc = {
	automatic = true;
	dates = "weekly";
	options = "-d";
	persistent = true;
};
}
