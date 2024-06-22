#!/run/current-system/sw/bin/bash

prevdir="$PWD"
cd /home/shade/.config/home-manager

git fetch origin

LOCAL=$(git rev-parse @)
REMOTE=$(git rev-parse @{u})

if [ "$LOCAL" != "$REMOTE" ]; then
	echo "Update found"
	echo "Synchronizing configuration with repository..."
	git pull
	rsync "/home/shade/.config/home-manager/nixsys/" "/etc/nixos/"
	nix-rebuild switch
fi
cd "$prevdir"
