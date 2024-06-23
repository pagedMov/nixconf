#!/run/current-system/sw/bin/bash

export HOME="/root"
export PATH=$PATH:/run/current-system/sw/bin
export NIX_PATH=/home/shade/.nix-defexpr/channels:nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos:nixos-config=/etc/nixos/configuration.nix:/nix/var/nix/profiles/per-user/root/channels
git config --global --add safe.directory /home/shade/.config/home-manager
prevdir="$PWD"
cd /home/shade/.config/home-manager

sudo -u shade git fetch origin

LOCAL=$(sudo -u shade git rev-parse @)
REMOTE=$(sudo -u shade git rev-parse @{u})


if [ "$LOCAL" != "$REMOTE" ]; then
	echo "Update found"
	echo "Synchronizing configuration with repository..."
	sudo -u shade git pull
	sudo -u shade rsync "/home/shade/.config/home-manager/nixsys/" "/etc/nixos/"
	nixos-rebuild switch
	echo "1" > .update
else
	echo "No update found"
fi
cd "$prevdir"
