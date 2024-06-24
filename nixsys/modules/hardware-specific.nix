{ config, lib, pkgs, ... }:

{
	boot.initrd.kernelModules = [ # For GPU passthrough to the windows VM
		"vfio-pci"
			"vfio"
			"xhci_pci"
			"amdgpu"
	];
	boot.kernelParams = [ "amd_iommu=on" "iommu=pt" "vfio-pci.ids=15b8,1002:73ff,1002:ab28" ]; # Kernel params for GPU passthrough
	virtualisation.libvirtd.enable = true;
	systemd.services = { # Mounting the windows 10 VM filesystem
		mount_windows={
			description = "Mount Win10 VM";
			wantedBy = [ "multi-user.target" ];
			serviceConfig = {
				Type = "oneshot";
				ExecStart = "/etc/nixos/scripts/mountwin11.sh";
			};
		};
	};
	environment.systemPackages = with pkgs; [ # Hardware specific packages
	libvirt
	qemu_full
	virtio-win
	bridge-utils
	qt6ct
	gtk3
	];
}
