#!/run/current-system/sw/bin/bash

# This script sends a notification if there is the system's repo hash is different from the remote hash
prevdir="$PWD"
cd ~/.config/home-manager

git fetch origin
LOCAL=$(sudo -u shade git rev-parse @)
REMOTE=$(sudo -u shade git rev-parse @{u})


if [ "$LOCAL" != "$REMOTE" ]; then
	notify-send "New config update available" "There is a new version of your configuration on the github repo. Do 'nixupdate' to install it to your system."
else
	echo "No update found"
fi
cd "$prevdir"
