#!/run/current-system/sw/bin/bash

mount -t tmpfs tmpfs /dev/shm

mount -t btrfs /dev/sda /dev/shm/btrfs_mount

snapdir="/snap/rootsnap"

if [ -d "$snapdir" ]; then
	rm -rf "$snapdir"
fi

btrfs subvolume create /dev/shm/btrfs_mount/root "$snapdir"
