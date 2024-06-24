#!/run/current-system/sw/bin/bash

prevdir="$PWD"
cd ~/.config/home-manager

git fetch origin
updatefile=$(cat .update)

if [ "$updatefile" == "1" ]; then
	echo "Update found"
	echo "Synchronizing configuration with repository..."
	git pull
	home-manager switch
	echo "0" > .update
fi
cd "$prevdir"
