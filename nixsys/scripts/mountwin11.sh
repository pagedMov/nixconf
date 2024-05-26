#!/run/current-system/sw/bin/bash

disks=$(/nix/store/jpbahkdhclhdqrs7ay8wlqdn0110aqbj-util-linux-2.39.3-bin/bin/lsblk --nodeps | grep 'nvme0n1')

if [ -n "$disks" ]; then
	 /nix/store/jpbahkdhclhdqrs7ay8wlqdn0110aqbj-util-linux-2.39.3-bin/bin/mount /dev/nvme0n1p1 /home/shade/vmStorage/ssdStorage
else
	echo "nvme0n1 not found."
	exit 0
fi


