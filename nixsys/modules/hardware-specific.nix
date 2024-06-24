{ config, lib, pkgs, ... }
{
	systemd.services = {
		mount_windows={
			description = "Mount Win10 VM";
			wantedBy = [ "multi-user.target" ];
			serviceConfig = {
				Type = "oneshot";
				ExecStart = "/etc/nixos/scripts/mountwin11.sh";
			};
		};
	};
	environment.systemPackages = with pkgs; [

	];
};
