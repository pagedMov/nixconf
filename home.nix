## line 31: environment init
## line 46: program configurations
## line 104: user services
## type : and then the line number to go there


{ config, pkgs, lib, ... }:

let
  homePkgs = import /home/shade/.config/home-manager/pack/homepack.nix { inherit pkgs; };
  fontPackages = import /home/shade/.config/home-manager/pack/fontpack.nix { inherit pkgs; };
  pypack = import ./pack/pypack.nix { inherit pkgs; };
in
{

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
  home.sessionVariables = {
  	NVIM_CONFIG = "/home/shade/.config/nvim/init.lua";
  };

######################################
####### PROGRAM CONFIGURATIONS #######
######################################

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
