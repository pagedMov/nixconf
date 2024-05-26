# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

let
  nixvim = import (builtins.fetchGit {
	url = "https://github.com/nix-community/nixvim";
	});
in

{
  imports =
    [ # Include the results of the hardware scan.
	./hardware-configuration.nix
	<home-manager/nixos>
	nixvim.nixosModules.nixvim
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.kernelModules = [
		"vfio-pci"
		"vfio"
		"xhci_pci"
		"amdgpu"
		];
  boot.kernelParams = [ "amd_iommu=on" "iommu=pt" "vfio-pci.ids=15b8,1002:73ff,1002:ab28" ];
  nixpkgs.config.allowUnfree = true;
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
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

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
  virtualisation.libvirtd.enable = true;  

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
   environment.systemPackages = with pkgs; [
	wget
	vim
	kanata
	mkinitcpio-nfs-utils
	gtk3
	gawk
	kitty
	inetutils
	less
	more
	unionfs-fuse
	rsync
	rsnapshot
	snapper
	git
	docker
	alsa-utils
	neofetch
	findutils
	coreutils
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
	tmux
	tree
	grc
	gnupg
	ffmpeg
	openssh
	nmap
	iotop
	libvirt
	qemu_full
	virtio-win
	bridge-utils
	qt6ct
	dbus
	usbutils
	home-manager
	xdg-desktop-portal-hyprland
   ];

    programs.nixvim = {
	enable = true;
	enableMan = true;
	colorschemes = {
		base16.enable = true;
		base16.colorscheme = "brewer"; 
#		base16.colorscheme = {
#			base00 = "#00000B";
#			base01 = "#404040";
#			base02 = "#68615e";
#			base03 = "#0E1F2F";
#			base04 = "#9c9491";
#			base05 = "#a8a19f";
#			base06 = "#e6e2e0";
#			base07 = "#f1efee";
#			base08 = "#00ADBE";
#			base09 = "#3F90FF";
#			base0A = "#4E3FFF";
#			base0B = "#30B974";
#			base0C = "#AE3FFF";
#			base0D = "#B600A6";
#			base0E = "#C03670";
#			base0F = "#AC3FFF";
#		};
	};
	opts = {
		number = true;
		relativenumber= true;
		smarttab = true;
		shiftwidth = 4;
		tabstop = 4;
		hlsearch = true;
		incsearch = true;
		ruler = true;
	};
	plugins = {
		copilot-vim.enable = false;
		commentary.enable = true;
		hardtime = {
			enable = true;
			disableMouse = true;
			restrictionMode = "hint";
		};
		lsp = {
			enable = true;
			servers.gopls.enable = true;
			servers.clangd.enable = true;
			servers.pyright = {
				enable = true;
				settings = {
					typeCheckingMode = "off";
					pythonPlatform = "Linux";
					reportOptionalMemberAccess = "none";
				 };
			};
		};
		autoclose = {
			enable = true;
			options = {
				autoIndent = true;
			};
		};
		competitest = {
			enable = true;
			settings = {
				runner_ui = {
					interface = "split";
				};
			};
		};
		cmp.enable = true;
		debugprint.enable = true;
		endwise.enable = true;
		barbar.enable = true;
		indent-blankline.enable = true;
		coq-nvim = {
			enable = true;
			installArtifacts = true;
			settings.auto_start = true;
			};
		treesitter = {
			enable = true;
			indent = true;
			nixvimInjections = true;
		};
		toggleterm.enable = true;
		trouble.enable = true;
		surround.enable = true;
		telescope.enable = true;
	};
	extraPlugins = with pkgs.vimPlugins; [
		vim-slash
	];
	extraConfigVim = ''
		command! Togglenum call ToggleNumbers()

		function! ToggleNumbers()
			if &number == 0
				set number relativenumber
			else
				set nonumber norelativenumber
			endif
		endfunction

		lua vim.diagnostic.config({ signs = false })

		autocmd InsertEnter * setlocal nocursorline nocursorcolumn
		autocmd VimEnter,InsertLeave * setlocal cursorline
		autocmd VimEnter,InsertLeave * setlocal cursorcolumn
		autocmd VimEnter * TroubleToggle 
		autocmd VimEnter * wincmd p
		nnoremap <silent>    <A-[> <Cmd>BufferPrevious<CR>
		nnoremap <silent>    <A-]> <Cmd>BufferNext<CR>	
		nnoremap <silent>    <C-[> <Cmd>BufferMovePrevious<CR>
		nnoremap <silent>    <C-]> <Cmd>BufferMoveNext<CR>
		nnoremap <space> zA
		inoremap {<CR> {<CR>}<C-o>O
		inoremap [<CR> [<CR>]<C-o>O
		inoremap (<CR> (<CR>)<C-o>O
		set foldmethod=indent
	'';
  };


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
	mount_windows={
		description = "Mount the windows 11 virtual machine storage volume";
		wantedBy = [ "multi-user.target" ];
		serviceConfig.Type = "oneshot";
		serviceConfig.ExecStart = "/etc/nixos/scripts/mountwin11.sh";
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
