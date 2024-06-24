{ config, lib, pkgs, ... }:

{
home.username = "shade";
home.homeDirectory = "/home/shade";
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
		update-check = {
			Unit = {
				Description = "Check for updates";
			};
			Service = {
				Type = "oneshot";
				ExecStart = "/home/shade/.config/home-manager/scripts/updatecheck.sh";
			};
		};
		backup-files = {
			Unit = {
				Description = "Backup files";
			};
			Service = {
				Type = "oneshot";
				ExecStart = "${pkgs.writeShellScript "backup-files" ''
					#!/run/current-system/sw/bin/bash
					export PATH=$PATH:/run/current-system/sw/bin
					scp /home/shade/finance/*.txt pagedmov@192.168.1.206:/home/pagedmov/inbox/backup;
					ssh pagedmov@192.168.1.206 "echo \"Backup completed at $(date)\" > /home/pagedmov/inbox/backup/lastbackup.txt";
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
					export PATH=$PATH:/run/current-system/sw/bin
					rm /home/shade/Downloads/*
				''}";
			};
		};
	};
};
}
