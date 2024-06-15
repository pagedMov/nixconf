## line 31: environment init
## line 46: program configurations
## line 104: user services
## type : and then the line number to go there


{ config, pkgs, lib, ... }:

let
  homePkgs = import /home/shade/.config/home-manager/pack/homepack.nix { inherit pkgs; };
  fontPackages = import /home/shade/.config/home-manager/pack/fontpack.nix { inherit pkgs; };
  pypack = import ./pack/pypack.nix { inherit pkgs; };
  nixvim = import (builtins.fetchGit {
	url = "https://github.com/nix-community/nixvim";
  });
in

{

  imports = [
	nixvim.homeManagerModules.nixvim
  ];
######################################
##### ENVIRONMENT INITIALIZATION #####
######################################
  home.username = "shade";
  home.homeDirectory = "/home/shade";
  home.enableNixpkgsReleaseCheck = false;
  home.stateVersion = "24.11";

  fonts.fontconfig.enable = true;
  home.packages = with pkgs ; [ pypack.pythonWithPackages ] ++ fontPackages ++ homePkgs;
  nixpkgs.config.allowUnfree = true;

######################################
####### PROGRAM CONFIGURATIONS #######
######################################

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
		codeium-vim = {
			enable = true;
			settings = {
				manual = true;
			};
			keymaps.next = "<C-;>";
			keymaps.prev = "<C-,>";
			keymaps.accept = "<C-Tab>";
			keymaps.complete = "<F1>";
		};
		trim = {
			enable = true;
			settings.highlight = true;
		};
		neoscroll = {
			enable = true;
			settings.hide_cursor = false;
		};
		twilight = {
			enable = false;
			settings.context = 20;
		};
		gitsigns.enable = true;
		fugitive.enable = true;
		cmp.enable = true;
		neogit.enable = true;
		refactoring.enable = true;
		floaterm.enable = true;
		neocord.enable = true;
		marks.enable = true;
		undotree.enable = true;
		endwise.enable = true;
		barbar.enable = true;
		indent-blankline.enable = true;
		coq-nvim = {
			enable = true;
			installArtifacts = true;
			settings.auto_start = false;
			};
		treesitter = {
			enable = true;
			indent = true;
			nixvimInjections = true;
		};
		trouble.enable = true;
		surround.enable = true;
		telescope.enable = true;
	};
	extraPlugins = with pkgs.vimPlugins; [
		vim-slash
		vim-sneak
	];
	autoCmd = [
		{
		event = [ "InsertEnter" ];
		pattern = [ "*" ];
		command = "setlocal nocursorline nocursorcolumn";
		}
		{
		event = [ "VimEnter" "InsertLeave" ];
		pattern = [ "*" ];
		command = "setlocal cursorline cursorcolumn";
		}
		{
		event = [ "VimEnter" ];
		pattern = [ "*" ];
		command = "set statusline=%{get(b:,'gitsigns_status','')}\\ %f\\ %h%m%r%=%-14.(%l,%c%V%)\\ %P";
		}
		{
		event = [ "VimEnter" ];
		pattern = [ "*" ];
		command = "TroubleToggle";
		}
		{
		event = [ "VimEnter" ];
		pattern = [ "*" ];
		command = "wincmd p";
		}
		{
		event = [ "VimEnter" ];
		pattern = [ "*" ];
		command = "FloatermNew --wintype=float --name=shadeterm --position=topright --autoclose=0 --silent --cwd=<buffer> --titleposition=left";
		}
		{
		event = [ "VimEnter" ];
		pattern = [ "*" ];
		command = "set foldmethod=indent";
		}
		{
		event = [ "VimEnter" ];
		pattern = [ "*" ];
		command = "set undofile";
		}
	];
	keymaps = [
		{
			action = "<Cmd>BufferNext<CR>";
			key = "<A-]>";
			mode = [ "n" ];
		}
		{
			action = "<Cmd>BufferPrevious<CR>";
			key = "<A-[>";
			mode = [ "n" ];
		}
		{
			action = "<Cmd>BufferMovePrevious<CR>";
			key = "<C-[>";
			mode = [ "n" ];
		}
		{
			action = "<Cmd>BufferMoveNext<CR>";
			key = "<C-]>";
			mode = [ "n" ];
		}
		{
			action = "zA";
			key = "<space>";
			mode = [ "n" ];
		}
		{
			action = ":FloatermToggle shadeterm<CR>";
			key = "<F2>";
			mode = [ "n" ];
		}
		{
			action = ":FloatermNew --wintype=float --name=rangerterm --position=topleft --autoclose=2 --opener=edit --cwd=<buffer> --titleposition=left ranger<CR><CR>";
			key = "<F3>";
			mode = [ "n" ];
		}
		{
			action = "<C-\\><C-n>:FloatermToggle shadeterm<CR>";
			key = "<F2>";
			mode = [ "t" ];
		}
		{
			action = "<C-\\><C-n>:FloatermKill rangerterm<CR>";
			key = "<F3>";
			mode = [ "t" ];
		}
		{
			action = "<Esc>";
			key = "<Esc>";
			mode = [ "n" "i" "v" "c" ];
		}
		{
			action = "function() require('refactoring').debug.printf({below = false})";
			key = "<leader>rp";
			mode = [ "n" ];
		}
		{
			action = "function() require('refactoring').debug.print_var()";
			key = "<leader>rv";
			mode = [ "x" "n" ];
		}
		{
			action = "function() require('refactoring').debug.cleanup({})";
			key = "<leader>rc";
			mode = [ "n" ];
		}
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
	'';
  };

  home.file = {
  ".nixalias" = {
  	text = ''
		#!/run/current-system/sw/bin/bash


		nix_search () {
			echo "$(cat ~/bin/packages.list)" | grep "$1" | awk '{print $1}'
		}
		nix_install () {
			if [ -z $1 ]; then echo "input a package name"
			elif sudo grep -q "$1" /home/shade/.config/home-manager/pack/homepack.nix; then
			  echo "package already installed"
			else
			  sed -i "/^\]/i$1" "/home/shade/.config/home-manager/pack/homepack.nix"
			  echo "added $1 to pack.txt, rebuild? (y/n)"
			  rebuildprompt
			fi
		}
		nix_install_font () {
			if [ -z $1 ]; then echo "input a package name"
			elif sudo grep -q "$1" /home/shade/.config/home-manager/pack/fontpack.nix; then
			  echo "package already installed"
			else
			  sed -i "/^\]/i$1" "/home/shade/.config/home-manager/pack/fontpack.nix"
			  echo "added $1 to fontpack.txt, rebuild? (y/n)"
			  rebuildprompt
			fi
		}
		nix_pip () {
			if [ -z $1 ]; then echo "input a python package name"
			elif grep -q "$1" /home/shade/.config/home-manager/pack/pypack.nix; then
				echo "python package already installed"
			else
				sed -i "/^])/i$1" "/home/shade/.config/home-manager/pack/pypack.nix"
				echo "added $1 to pypack.nix, rebuild? (y/n)"
				rebuildprompt
			fi
		}
		nix_find_path () {
			sudo find / -name "$1"
		 }
		nix_remove () {
			sed -i "/$1/d" /home/shade/.config/home-manager/pack/homepack.nix
			echo "$1 removed from homepack.nix"
			echo "rebuild? (y/n)"
			rebuildprompt
		}
		rebuildprompt () {
			undecided=true; while $undecided; do read yn
				if [ $yn == "y" ]; then
					echo "rebuilding..."
					sleep 1
					home-manager switch
					undecided=false
					 echo " "
					echo "rebuild complete."
				elif [ $yn == "n" ]; then
					echo "exiting without rebuilding."
					return 1
				else
					echo "input y or n"
				fi
			done
		}
		nix_installed () {
			if [ -n "$1" ] && [ $1 == "open" ]; then
				nvim /home/shade/.config/home-manager/pack/homepack.nix
				return 0
			elif [ -n "$1" ] && [ $1 != "open" ]; then
				echo "invalid option"
				return 1
			else
				cat /home/shade/.config/home-manager/pack/homepack.nix
			fi
		}
		nix_help () {
			echo
			echo "--- config commands ---" \
			&& echo "nixconf - edit system config" \
			&& echo "nixhardconf - edit hardware config" \
			&& echo "shadeconf - edit home-manager config" \
			&& echo "nixfind - find path to command" \
			&& echo "nixrebuild - rebuild nixos system" \
			&& echo "shaderebuild - rebuild home-manager config" \
			&& echo \
			&& echo "--- package commands ---" \
			&& echo "nixsearch <pkg> - search for a package" \
			&& echo "nixinstalled <?open> - list installed packages, or open pack.nix with \"open\" arg" \
			&& echo "nixinstall <pkg> - install a package" \
			&& echo "nixinstallfont <pkg> - install a font" \
			&& echo "nixpip <pkgs> - install a python lib" \
			&& echo "nixremove <pkg> - remove a package" \
			&& echo "nixhelp - show this message"
		}

		alias nixconf="sudo nvim /etc/nixos/configuration.nix"

		alias shadeconf="home-manager edit"

		alias nixhardconf="sudo nvim /etc/nixos/hardware-configuration.nix"

		alias nixsearch=nix_search

		alias shaderebuild="home-manager switch"

		alias nixrebuild="sudo nixos-rebuild switch"

		alias nixinstall=nix_install

		alias nixinstallfont=nix_install_font

		alias nixremove=nix_remove

		alias nixfind=nix_find_path

		alias nixpip=nix_pip

		alias nixinstalled=nix_installed

		alias nixhelp=nix_help
	'';
  };
  ".bashrc" = {
	text = ''
	# Environment variables
	export PATH="/home/shade/bin:$PATH"
	export PS1="\n\[\033[1;38;2;176;0;176m\][\[\e]0;\u@\h: \w\a\]\u@\h:\w]\$ \[\033[0m\]"
	export EDITOR="nvim"

	# Alias
	source /home/shade/.nixalias
	alias win10on="sudo virsh start win10 && sudo virsh attach-device win10 /home/shade/vmStorage/devices/headset.xml"
	alias win10off="sudo virsh shutdown win10 && sudo virsh detach-device win10 /home/shade/vmStorage/devices/headset.xml"
	alias hyprconf="nvim ~/.dotfiles/.hyprland"
'';
  };
  ".config/hypr/hyprland.conf" = {
	text = ''
	# hyprland config


	# monitors
	monitor=DP-2,1920x1080@144,1920x0,1
	monitor=HDMI-A-1,1920x1080@60,0x0,1

	# workspaces
	workspace = 1,monitor:HDMI-A-1, default:true, persistent:true
	workspace = 2,monitor:DP-2,default:true,persistent:true
	workspace = 3,monitor:HDMI-A-1,persistent:true
	workspace = 4,monitor:DP-2,persistent:true
	workspace = special:console,on-created-empty:[float;size 45% 45%;move 1% 4%] kitty

	# autoexec
	exec-once=waybar
	exec-once=hyprpaper
	exec-once=copyq --start-server
	exec-once=ollama serve
	exec-once=python "/home/shade/.config/eww/scripts/playermeta.py"

	# environment variables
	$terminal = kitty
	$filemanager = kitty ranger
	$menu = rofi -show drun
	$screenshot = grimblast copy area
	$browser = brave
	env = qt_qpa_platformtheme,qt6ct

	# settings
	input {
		kb_layout = us
		follow_mouse = 1
		sensitivity = 0
	}
	general {
		gaps_in = 5
		gaps_out = 20
		border_size = 2
		col.active_border = rgb(7fc7c7)
		col.inactive_border = rgb(525252)
		layout = dwindle
		allow_tearing = false
	}
	decoration {
		dim_special = 0.2
	}
	animations {
		enabled = yes
		bezier = mybezier, 0.05, 0.9, 0.1, 1.05
		animation = windows, 1, 7, mybezier
		animation = border, 1, 10, default
		animation = borderangle, 1, 8, default
		animation = fade, 1, 7, default
		animation = workspaces, 1, 6, default
	}
	dwindle {
		pseudotile = yes
		preserve_split = yes
	}
	master {
		new_is_master = true
	}
	misc {
		force_default_wallpaper = 1
	}

	# bindings
	$mainmod = super
	bind = $mainmod, up, exec, pactl set-sink-volume @default_sink@ +10%
	bind = $mainmod, down, exec, pactl set-sink-volume @default_sink@ -10%
	bind = ctrl shift, print, exec, grimblast copy area
	bind = $mainmod shift, q, exec, firefox
	bind = $mainmod, a, exec, brave
	bind = $mainmod, q, exec, $terminal
	bind = $mainmod, c, killactive,
	bind = $mainmod, m, exit,
	bind = $mainmod, e, exec, $filemanager
	bind = $mainmod, v, togglefloating,
	bind = $mainmod, r, exec, $menu
	bind = $mainmod, p, pseudo, # dwindle
	bind = $mainmod, b, togglesplit, # dwindle
	bind = $mainmod, f, togglefloating
	bind = $mainmod, home, exec, /home/pagedmov/scripts/home.sh
	bind = $mainmod, h, movefocus, l
	bind = $mainmod, l, movefocus, r
	bind = $mainmod, k, movefocus, u
	bind = $mainmod, j, movefocus, d
	bind = alt, q, focuscurrentorlast
	bind = $mainmod, 1, exec, hyprctl "dispatch workspace 1"
	bind = $mainmod, 2, exec, hyprctl "dispatch workspace 2"
	bind = $mainmod, 3, exec, hyprctl "dispatch workspace 3"
	bind = $mainmod, 4, exec, hyprctl "dispatch workspace 4"
	bind = $mainmod, 5, exec, hyprctl "dispatch workspace 5"
	bind = $mainmod, 6, exec, hyprctl "dispatch workspace 6"
	bind = $mainmod, 7, exec, hyprctl "dispatch workspace 7"
	bind = $mainmod, 8, exec, hyprctl "dispatch workspace 8"
	bind = $mainmod, 9, exec, hyprctl "dispatch workspace 9"
	bind = $mainmod, 0, exec, hyprctl "dispatch workspace 10"
	bind = $mainmod alt, g, togglegroup
	bind = $mainmod alt, h, changegroupactive, b
	bind = $mainmod alt, l, changegroupactive, f
	bind = $mainmod shift, h, movewindoworgroup, l
	bind = $mainmod shift, l, movewindoworgroup, r
	bind = $mainmod shift, k, movewindoworgroup, u
	bind = $mainmod shift, j, movewindoworgroup, d
	bind = $mainmod shift, 1, movetoworkspace, 1
	bind = $mainmod shift, 2, movetoworkspace, 2
	bind = $mainmod shift, 3, movetoworkspace, 3
	bind = $mainmod shift, 4, movetoworkspace, 4
	bind = $mainmod shift, 5, movetoworkspace, 5
	bind = $mainmod shift, 6, movetoworkspace, 6
	bind = $mainmod shift, 7, movetoworkspace, 7
	bind = $mainmod shift, 8, movetoworkspace, 8
	bind = $mainmod shift, 9, movetoworkspace, 9
	bind = $mainmod shift, 0, movetoworkspace, 10
	bind = $mainmod, s, togglespecialworkspace, magic
	bind = $mainmod shift, s, movetoworkspace, special:magic
	bind = alt, grave, togglespecialworkspace, console
	bind = $mainmod, mouse_down, workspace, e+1
	bind = $mainmod, mouse_up, workspace, e-1
	bindm = $mainmod, mouse:272, movewindow
	bindm = $mainmod, mouse:273, resizewindow
'';
  };
  ".config/hypr/hyprpaper.conf" = {
	text = ''
	preload = /home/shade/Pictures/wallpapers_/touhou/nitori.png
	wallpaper = HDMI-A-1,/home/shade/Pictures/wallpapers_/touhou/nitori.png
	wallpaper = DP-2,/home/shade/Pictures/wallpapers_/touhou/nitori.png
	splash = false
	ipc = off
	'';
  };
  ".config/kitty/kitty.conf"= {
	text = ''
	confirm_os_window_close 0

	# Base16 Primer Dark - kitty color config
	# Scheme by Jimmy Lin
	background #010409
	foreground #b1bac4
	selection_background #b1bac4
	selection_foreground #010409
	url_color #8b949e
	cursor #b1bac4
	active_border_color #484f58
	inactive_border_color #21262d
	active_tab_background #010409
	active_tab_foreground #b1bac4
	inactive_tab_background #21262d
	inactive_tab_foreground #8b949e
	tab_bar_background #21262d

	# normal
	color0 #010409
	color1 #ff7b72
	color2 #3fb950
	color3 #d29922
	color4 #58a6ff
	color5 #f778ba
	color6 #a5d6ff
	color7 #b1bac4

	# bright
	color8 #484f58
	color9 #f0883e
	color10 #21262d
	color11 #30363d
	color12 #8b949e
	color13 #c9d1d9
	color14 #bd561d
	color15 #f0f6fc
'';
  };
  ".config/waybar/config" = {
	text = ''
	{
		"layer": "top",
		"position": "top",

		"modules-left": [
			"hyprland/mode",
			"hyprland/workspaces",
			"custom/arrow10",
			"mpris"
		],

		"modules-right": [
			"custom/arrow9",
			"pulseaudio",
			"custom/arrow8",
			"network",
			"custom/arrow7",
			"memory",
			"custom/arrow6",
			"cpu",
			"custom/arrow5",
			"disk",
			"custom/arrow3",
			"hyprland/language",
			"custom/arrow2",
			"tray",
			"clock#date",
			"custom/arrow1",
			"clock#time"
		],

		// Modules

		"mpris": {
			"format": "{player_icon} {title} - {position}/{length}",
			"format-paused": "{status_icon} {title} - {position}/{length}",
			"player-icons": {
				"default": "▶"
			},
			"status-icons": {
				"paused": "⏸",
				"stopped": ""
			},
			"dynamic-len": 90,
			"dynamic-importance-order": ["title","artist","position","length","album"],
			"interval": 1
		},

		"battery": {
			"interval": 10,
			"states": {
				"warning": 30,
				"critical": 15
			},
			"format-time": "{H}:{M:02}",
			"format": "{icon} {capacity}% ({time})",
			"format-charging": " {capacity}% ({time})",
			"format-charging-full": " {capacity}%",
			"format-full": "{icon} {capacity}%",
			"format-alt": "{icon} {power}W",
			"format-icons": [
				"",
				"",
				"",
				"",
				""
			],
			"tooltip": false
		},

		"clock#time": {
			"interval": 10,
			"format": "{:%H:%M}",
			"tooltip": false
		},

		"clock#date": {
			"interval": 20,
			"format": "{:%e %b %Y}",
			"tooltip": false
			//"tooltip-format": "{:%e %B %Y}"
		},

		"cpu": {
			"interval": 5,
			"tooltip": false,
			"format": " {usage}%",
			"format-alt": " {load}",
			"states": {
				"warning": 70,
				"critical": 90
			}
		},

		"hyprland/language": {
			"format": " {}",
			"min-length": 15,
			"on-click": "swaymsg 'input * xkb_switch_layout next'",
			"tooltip": false
		},

		"memory": {
			"interval": 5,
			"format": " {used:0.1f}G/{total:0.1f}G",
			"states": {
				"warning": 70,
				"critical": 90
			},
			"tooltip": false
		},

		"network": {
			"interval": 5,
			"format-wifi": " {essid} ({signalStrength}%)",
			"format-ethernet": " {ifname}",
			"format-disconnected": "No connection",
			"format-alt": " {ipaddr}/{cidr}",
			"tooltip": false
		},

		"hyprland/mode": {
			"format": "{}",
			"tooltip": false
		},

		"hyprland/window": {
			"format": "{}",
			"max-length": 45,
			"tooltip": false
		},

		"hyprland/workspaces": {
			"disable-scroll-wraparound": true,
			"smooth-scrolling-threshold": 4,
			"enable-bar-scroll": true,
			"format": "{name}"
		},

		"pulseaudio": {
			"format": "{icon} {volume}%",
			"format-bluetooth": "{icon} {volume}%",
			"format-muted": "",
			"format-icons": {
				"headphone": "",
				"hands-free": "",
				"headset": "",
				"phone": "",
				"portable": "",
				"car": "",
				"default": ["", ""]
			},
			"scroll-step": 1,
			"on-click": "pactl set-sink-mute @DEFAULT_SINK@ toggle",
			"tooltip": false
		},

		"disk": {
		"format": " {percentage_used}%",
		"tooltip": true,
		"interval": 30
		},
		"temperature": {
			"critical-threshold": 90,
			"interval": 5,
			"format": "{icon} {temperatureC}°",
			"format-icons": [
				"",
				"",
				"",
				"",
				""
			],
			"tooltip": false
		},

		"tray": {
			"icon-size": 18
			//"spacing": 10
		},

		"custom/arrow1": {
			"format": "",
			"tooltip": false
		},

		"custom/arrow2": {
			"format": "",
			"tooltip": false
		},

		"custom/arrow3": {
			"format": "",
			"tooltip": false
		},

		"custom/arrow4": {
			"format": "",
			"tooltip": false
		},

		"custom/arrow5": {
			"format": "",
			"tooltip": false
		},

		"custom/arrow6": {
			"format": "",
			"tooltip": false
		},

		"custom/arrow7": {
			"format": "",
			"tooltip": false
		},

		"custom/arrow8": {
			"format": "",
			"tooltip": false
		},

		"custom/arrow9": {
			"format": "",
			"tooltip": false
		},

		"custom/arrow10": {
			"format": "",
			"tooltip": false
		}
	}

	// vi:ft=jsonc
	'';
  };
  ".config/waybar/style.css" = {
	text = ''
	/* Keyframes */

	@keyframes blink-critical {
		to {
			/*color: @white;*/
			background-color: @critical;
		}
	}


	/* Styles */

	/* Colors (gruvbox) */
	@define-color black	#282828;
	@define-color red	#cc241d;
	@define-color green	#98971a;
	@define-color yellow	#d79921;
	@define-color blue	#458588;
	@define-color purple	#b16286;
	@define-color aqua	#689d6a;
	@define-color gray	#a89984;
	@define-color brgray	#928374;
	@define-color brred	#fb4934;
	@define-color brgreen	#b8bb26;
	@define-color bryellow	#fabd2f;
	@define-color brblue	#83a598;
	@define-color brpurple	#d3869b;
	@define-color braqua	#8ec07c;
	@define-color white	#ebdbb2;
	@define-color bg2	#504945;
	@define-color orange #d9a54b;

	@define-color warning 	@bryellow;
	@define-color critical	@red;
	@define-color mode	@black;
	@define-color unfocused	@bg2;
	@define-color focused	@braqua;
	@define-color inactive	@purple;
	@define-color sound	@braqua;
	@define-color network	@purple;
	@define-color memory	@green;
	@define-color cpu	@brgreen;
	@define-color temp	@bryellow;
	@define-color layout	@orange;
	@define-color battery	@aqua;
	@define-color date	@black;
	@define-color time	@white;

	/* Reset all styles */
	* {
		border: none;
		border-radius: 0;
		min-height: 0;
		margin: 0;
		padding: 0;
		box-shadow: none;
		text-shadow: none;
		icon-shadow: none;
	}

	/* The whole bar */
	#waybar {
		background: rgba(40, 40, 40, 0.8784313725); /* #282828e0 */
		color: @white;
		font-family: JetBrains Mono, Siji;
		font-size: 12pt;
		/*font-weight: bold;*/
	}

	/* Each module */
	#battery,
	#clock,
	#cpu,
	#language,
	#memory,
	#mode,
	#network,
	#pulseaudio,
	#temperature,
	#tray,
	#backlight,
	#idle_inhibitor,
	#disk,
	#user,
	#mpris {
		padding-left: 8pt;
		padding-right: 8pt;
	}

	/* Each critical module */
	#mode,
	#memory.critical,
	#cpu.critical,
	#temperature.critical,
	#battery.critical.discharging {
		animation-timing-function: linear;
		animation-iteration-count: infinite;
		animation-direction: alternate;
		animation-name: blink-critical;
		animation-duration: 1s;
	}

	/* Each warning */
	#network.disconnected,
	#memory.warning,
	#cpu.warning,
	#temperature.warning,
	#battery.warning.discharging {
		color: @warning;
	}

	/* And now modules themselves in their respective order */

	/* Current sway mode (resize etc) */
	#mode {
		color: @white;
		background: @mode;
	}

	/* Workspaces stuff */
	#workspaces button {
		/*font-weight: bold;*/
		padding-left: 2pt;
		padding-right: 2pt;
		color: @white;
		background: @unfocused;
	}

	/* Inactive (on unfocused output) */
	#workspaces button.visible {
		color: @white;
		background: @inactive;
	}

	/* Active (on focused output) */
	#workspaces button.focused {
		color: @black;
		background: @focused;
	}

	/* Contains an urgent window */
	#workspaces button.urgent {
		color: @black;
		background: @warning;
	}

	/* Style when cursor is on the button */
	#workspaces button:hover {
		background: @black;
		color: @white;
	}

	#window {
		margin-right: 35pt;
		margin-left: 60pt;
	}

	#pulseaudio {
		background: @sound;
		color: @black;
	}

	#network {
		background: @battery;
		color: @white;
	}

	#memory {
		background: @memory;
		color: @white;
	}

	#cpu {
		background: @cpu;
		color: @black;
	}

	#disk {
		background: @temp;
		color: @black;
	}

	#language {
		background: @layout;
		color: @black;
	}

	#tray {
		background: @date;
	}

	#clock.date {
		background: @date;
		color: @white;
	}

	#clock.time {
		background: @time;
		color: @black;
	}

	#custom-arrow1 {
		font-size: 11pt;
		color: @time;
		background: @date;
	}

	#custom-arrow2 {
		font-size: 11pt;
		color: @date;
		background: @layout;
	}

	#custom-arrow3 {
		font-size: 11pt;
		color: @layout;
		background: @temp;
	}

	#custom-arrow4 {
		font-size: 11pt;
		color: @temp;
		background: @temp;
	}

	#custom-arrow5 {
		font-size: 11pt;
		color: @temp;
		background: @cpu;
	}

	#custom-arrow6 {
		font-size: 11pt;
		color: @cpu;
		background: @memory;
	}

	#custom-arrow7 {
		font-size: 11pt;
		color: @memory;
		background: @battery;
	}

	#custom-arrow8 {
		font-size: 11pt;
		color: @battery;
		background: @sound;
	}

	#custom-arrow9 {
		font-size: 11pt;
		color: @sound;
		background: transparent;
	}

	#custom-arrow10 {
		font-size: 11pt;
		color: @unfocused;
		background: transparent;
	}
	'';
  };
  };

  gtk = {
	enable = true;
	theme = {
		name = "Graphite-Dark";
		package = pkgs.graphite-gtk-theme;
		};
	};

#####################################
########## USER SERVICES ############
#####################################


  systemd.user = {
  		timers = {
			backup-files = {
				Unit = {
					Description = "Backup files";
					};
				Timer = {
					OnCalendar = "*-*-* 21:00:00";
					Persistent = true;
				};
				Install = {
					WantedBy = [ "timers.target" ];
				};
			};
			clean-downloads = {
				Unit = {
					Description = "Clean Downloads Folder";
				};
				Timer = {
					OnCalendar = "weekly";
					Persistent = true;
				};
				Install = {
					WantedBy = [ "timers.target" ];
				};
			};
		};
		services = {
			backup-files = {
				Unit = {
					Description = "Backup files";
				};
				Service = {
					Type = "oneshot";
					ExecStart = "${pkgs.writeShellScript "backup-files" ''
						#!/run/current-system/sw/bin/bash
						/nix/store/yzymlkgcamps2jr5gbslcydcrwj4gw8n-openssh-9.7p1/bin/scp /home/shade/finance/*.txt pagedmov@192.168.1.206:/home/pagedmov/inbox/backup;
						/nix/store/yzymlkgcamps2jr5gbslcydcrwj4gw8n-openssh-9.7p1/bin/ssh pagedmov@192.168.1.206 "echo \"Backup completed at $(date)\" > /home/pagedmov/inbox/backup/lastbackup.txt";
					''}";
				};
			};
			update-packages = {
				Unit = {
					Description = "Update packages.list for use with nixsearch";
				};
				Install = {
					WantedBy = [ "default.target" ];
				};
				Service = {
					Type = "oneshot";
					ExecStart = "${pkgs.writeShellScript "update-packlist" ''
						#!/run/current-system/sw/bin/bash
						echo "Last update: $(/nix/store/asqa3kfq3maclk7cqqhrjvp7vriw6ahy-coreutils-9.5/bin/date)"
						/nix/store/03a4f9rij2z4mmwprlbip3mrnnfaw0yd-nix-2.18.2/bin/nix-env -qaP > /home/shade/bin/packages.list
						''}";
				};
			};
			clean-downloads = {
				Unit = {
					Description = "Clear downloads folder";
				};
				Service = {
					Type = "oneshot";
					ExecStart = "${pkgs.writeShellScript "clean-downloads" ''
						#!/run/current-system/sw/bin/bash
						/nix/store/php4qidg2bxzmm79vpri025bqi0fa889-coreutils-9.5/bin/rm /home/shade/Downloads/*
					''}";
				};
			};
		};
  };
}
