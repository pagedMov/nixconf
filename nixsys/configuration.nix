# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:
let
sysPkgs = import /etc/nixos/modules/syspack.nix { inherit pkgs; };
configGeneration = "174";
in
{
	imports =
		[ # Include the results of the hardware scan.
		./hardware-configuration.nix
		<home-manager/nixos>
		./modules/hardware-specific.nix 
		];

# Use the systemd-boot EFI boot loader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	nixpkgs.config.allowUnfree = true;
#  environment.etc."udev/rules.d/50-uhk60.rules".text = ''
#  SUBSYSTEM=="input", ATTRS{idVendor}=="1d50", ATTRS{idProduct}=="612[0-7]", GROUP="input", MODE="0660"
#  SUBSYSTEMS=="usb", ATTRS{idVendor}=="1d50", ATTRS{idProduct}=="612[0-7]", TAG+="uaccess"
#  KERNEL=="hidraw*", ATTRS{idVendor}=="1d50", ATTRS{idProduct}=="612[0-7]", TAG+="uaccess"
#  '';
	environment.etc."issue".text = ''

\e[38;5;27m▓▓▓▓       \e[38;5;81m▒▒▒▒    ▒▒▒▒
\e[38;5;27m▓▓▓▓       \e[38;5;81m▒▒▒▒  ▒▒▒▒            \e[38;5;27m                       ▓▓▓
\e[38;5;27m▓▓▓▓       \e[38;5;81m▒▒▒▒▒▒▒▒             \e[38;5;27m  ▓▓▓          ▓▓     ▓▓▓▓▓                  \e[38;5;81m    ▒▒▒▒▒▒▒▒▒        ▒▒▒▒▒▒▒▒▒
\e[38;5;27m▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓\e[38;5;81m▒▒▒▒▒▒    \e[38;5;27m▓▓        \e[38;5;27m ▓▓▓▓▓        ▓▓▓▓     ▓▓▓                   \e[38;5;81m   ▒▒▒▒▒▒▒▒▒▒▒      ▒▒▒▒▒▒▒▒▒▒▒
\e[38;5;27m▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓\e[38;5;81m▒▒▒▒    \e[38;5;27m▓▓▓        \e[38;5;27m ▓▓▓▓▓▓       ▓▓▓▓                           \e[38;5;81m  ▒▒▒▒▒   ▒▒▒▒▒    ▒▒▒▒    ▒▒▒▒▒
\e[38;5;81m▒▒▒▒         \e[38;5;81m▒▒▒▒  \e[38;5;27m▓▓▓▓        \e[38;5;27m ▓▓▓▓▓▓▓      ▓▓▓▓                           \e[38;5;81m  ▒▒▒▒     ▒▒▒▒   ▒▒▒▒
\e[38;5;81m▒▒▒▒           \e[38;5;81m▒▒▒▒\e[38;5;27m▓▓▓▓         \e[38;5;27m ▓▓▓▓▓▓▓▓     ▓▓▓▓    ▓▓▓▓     ▓▓▓      ▓▓▓  \e[38;5;81m  ▒▒▒       ▒▒▒   ▒▒▒▒
\e[38;5;81m▒▒▒▒▒▒▒▒▒▒▒             \e[38;5;81m▒▒\e[38;5;27m▓▓▓▓          \e[38;5;27m ▓▓▓▓ ▓▓▓▓    ▓▓▓▓    ▓▓▓▓     ▓▓▓▓    ▓▓▓▓  \e[38;5;81m  ▒▒▒       ▒▒▒   ▒▒▒▒▒
\e[38;5;81m ▒▒▒▒▒▒▒▒▒\e[38;5;27m               \e[38;5;27m▓▓▓▓▓▓▓▓▓      \e[38;5;27m ▓▓▓▓  ▓▓▓▓   ▓▓▓▓     ▓▓▓      ▓▓▓▓  ▓▓▓▓   \e[38;5;81m  ▒▒▒       ▒▒▒    ▒▒▒▒▒▒▒▒▒
\e[38;5;81m▒▒▒▒\e[38;5;27m▓▓             \e[38;5;27m▓▓▓▓▓▓▓▓▓▓▓     \e[38;5;27m ▓▓▓▓   ▓▓▓▓  ▓▓▓▓     ▓▓▓       ▓▓▓▓▓▓▓▓    \e[38;5;81m  ▒▒▒       ▒▒▒      ▒▒▒▒▒▒▒▒▒
\e[38;5;81m▒▒▒▒\e[38;5;27m▓▓▓▓           \e[38;5;27m▓▓▓▓             \e[38;5;27m ▓▓▓▓    ▓▓▓▓ ▓▓▓▓     ▓▓▓        ▓▓▓▓▓▓     \e[38;5;81m  ▒▒▒       ▒▒▒            ▒▒▒▒▒
\e[38;5;81m▒▒▒▒  \e[38;5;27m▓▓▓▓         \e[38;5;27m▓▓▓▓              \e[38;5;27m ▓▓▓▓     ▓▓▓▓▓▓▓▓     ▓▓▓        ▓▓▓▓▓▓     \e[38;5;81m  ▒▒▒       ▒▒▒             ▒▒▒▒
\e[38;5;81m▒▒▒    \e[38;5;27m▓▓▓▓\e[38;5;81m▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒        \e[38;5;27m ▓▓▓▓      ▓▓▓▓▓▓▓     ▓▓▓       ▓▓▓▓▓▓▓▓    \e[38;5;81m  ▒▒▒▒     ▒▒▒▒             ▒▒▒▒
\e[38;5;81m▒▒    \e[38;5;27m▓▓▓▓▓▓\e[38;5;81m▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒         \e[38;5;27m ▓▓▓▓       ▓▓▓▓▓▓    ▓▓▓▓▓     ▓▓▓▓  ▓▓▓▓   \e[38;5;81m  ▒▒▒▒▒   ▒▒▒▒▒   ▒▒▒▒▒    ▒▒▒▒▒
\e[38;5;27m▓▓▓▓▓▓▓▓       \e[38;5;81m▒▒▒▒             \e[38;5;27m ▓▓▓▓        ▓▓▓▓▓    ▓▓▓▓▓    ▓▓▓▓    ▓▓▓▓  \e[38;5;81m   ▒▒▒▒▒▒▒▒▒▒▒     ▒▒▒▒▒▒▒▒▒▒▒▒
\e[38;5;27m▓▓▓▓  ▓▓▓▓       \e[38;5;81m▒▒▒▒            \e[38;5;27m  ▓▓          ▓▓▓      ▓▓▓     ▓▓▓      ▓▓▓  \e[38;5;81m    ▒▒▒▒▒▒▒▒▒       ▒▒▒▒▒▒▒▒▒
\e[38;5;27m▓▓▓▓    ▓▓▓▓       \e[38;5;81m▒▒▒▒

\e[1;32mSystem Administrator\e[0m: Kyler Clay
\e[1;32mContact\e[0m: kylerclay@proton.me
404-769-0559

Run '\e[1;35mnixos-help\e[0m' for the NixOS manual.
Run '\e[1;35mHyprland\e[0m' to enter the desktop environment.
		'';

# networking.hostName = "nixos"; # Define your hostname.
# Pick only one of the below networking options.
# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
	networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
	networking.hostName = "HAUNTER";
	networking.nameservers = [
		"68.94.156.9"
		"68.94.157.9"
	];

# Set your time zone.
	time.timeZone = "America/New_York";

# Configure network proxy if necessary
# networking.proxy.default = "http://user:password@proxy:port/";
# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

# Select internationalisation properties.
	i18n.defaultLocale = "en_US.UTF-8";
	console = {
		earlySetup = true;
		packages = with pkgs; [ terminus_font ];
		font = "Cyr_a8x14";
#  keyMap = "us";
		useXkbConfig = true; # use xkb.options in tty.
	};

	programs.hyprland.enable = true;
	programs.dconf.enable = true;

# Enable the Plasma 5 Desktop Environment.
# services.displayManager.sddm.enable = true;
# services.xserver.desktopManager.plasma5.enable = true;


# Configure keymap in X11
	services.xserver.xkb.layout = "us";
	services.xserver.xkb.options = "eurosign:e,caps:escape";


# Enable CUPS to print documents.
	services.printing.enable = true;

# Enable sound.
# hardware.pulseaudio.enable = true;
# OR
	services.pipewire = {
		enable = true;
		pulse.enable = true;
	};

# Enable touchpad support (enabled default in most desktopManager).
# services.xserver.libinput.enable = true;

# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.shade= {
		initialPassword = "1234";
		isNormalUser = true;
		extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
			packages = with pkgs; [
			];
	};
	home-manager.users.shade = { pkgs, ...}: {
		imports = [ /home/shade/.config/home-manager/home.nix ];
	};

# List packages installed in system profile. To search, run:
# $ nix search wget
	environment.systemPackages = with pkgs; sysPkgs;



# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
# programs.mtr.enable = true;

# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
# programs.mtr.enable = true;
# programs.gnupg.agent = {
#   enable = true;
#   enableSSHSupport = true;
# };

# List services that you want to enable:

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


# Enable the OpenSSH daemon.
	services.openssh.enable = true;

# Open ports in the firewall.
# networking.firewall.allowedTCPPorts = [ ... ];
# networking.firewall.allowedUDPPorts = [ ... ];
# Or disable the firewall altogether.
# networking.firewall.enable = false;

# Copy the NixOS configuration file and link it from the resulting system
# (/run/current-system/configuration.nix). This is useful in case you
# accidentally delete configuration.nix.
# system.copySystemConfiguration = true;
	system.stateVersion = "24.05";
}
