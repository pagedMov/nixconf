# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:
let
sysPkgs = import /etc/nixos/modules/syspack.nix { inherit pkgs; };
configGeneration = "174";
in
{
	system.stateVersion = "24.05";
	imports =
		[
		./hardware-configuration.nix
		<home-manager/nixos>
		./modules/hardware-specific.nix 
		./modules/issue.nix
		];

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	nixpkgs.config.allowUnfree = true;
	environment.systemPackages = with pkgs; sysPkgs;

	networking.networkmanager.enable = true;
	networking.hostName = "HAUNTER";
	networking.nameservers = [
		"68.94.156.9"
		"68.94.157.9"
	];

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

	users.users.shade= {
		initialPassword = "1234";
		isNormalUser = true;
		extraGroups = [ "wheel" ];
			packages = with pkgs; [
			];
	};
	home-manager.users.shade = { pkgs, ...}: {
		imports = [ /home/shade/.config/home-manager/home.nix ];
	};

	nix.gc = {
		automatic = true;
		dates = "weekly";
		options = "-d";
		persistent = true;
	};

	systemd.services = {
		update_config={
			description = "Check Nix Config Repo";
			after = [ "network.target" "multi-user.target" ];
			wantedBy = [ "multi-user.target" ];
			serviceConfig = {
				Type = "oneshot";
				ExecStart = "/etc/nixos/scripts/updatecheck.sh";
			};
		};
	};
}
