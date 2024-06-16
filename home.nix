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
  ".nixalias".source = 						dotfiles/.nixalias;
  ".bashrc".source = 						dotfiles/.bashrc;
  ".config/hypr/hyprland.conf".source = 	dotfiles/hyprland.conf;
  ".config/hypr/hyprpaper.conf".source = 	dotfiles/hyprpaper.conf;
  ".config/kitty/kitty.conf".source = 		dotfiles/kitty.conf;
  ".config/waybar/config".source = 			dotfiles/waybar.conf;
  ".config/waybar/style.css".source = 		dotfiles/waybarstyle.css;
  ".config/dunst/dunstrc".source = 			dotfiles/dunstrc;
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
