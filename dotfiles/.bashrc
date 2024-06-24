# Initialization commands
	xhost si:localuser:root
	clear

# Environment variables
	export PATH="$HOME/bin:$PATH"
	export PS1="\n\[\033[1;38;2;176;0;176m\][\[\e]0;\u@\h: \w\a\]\u@\h:\w]\$ \[\033[0m\]"
	export EDITOR="neovide"
	export NVIM_CONFIG="$HOME/.config/nvim/init.lua"
	export BASHRC="$HOME/.config/home-manager/dotfiles/.bashrc"
	export HYPRCONF="$HOME/.config/home-manager/dotfiles/hyprland.conf"
	export HM_DIR="$HOME/.config/home-manager"
	export NIX_DIR="/etc/nixos"
	export DOTFILES="$HOME/.config/home-manager/dotfiles"
	export SYSD_DIR="$HOME/.config/systemd/user"
	export LOCAL_IP="$(ip -4 addr show $(ip route show default | awk '/default/ {print $5}') | grep -oP '(?<=inet\s)\d+(\.\d+){3}')"

# Functions
	send_to_server() {
		if [ $# -eq 0 ]; then
			echo "Usage: send_to_server <file_path>"
			return 1
		fi

		local file_path=$1
		local server_user="pagedmov"
		local server_address="192.168.1.206"
		local destination_path="/home/pagedmov/inbox"

		scp "$file_path" "${server_user}@${server_address}:${destination_path}"
	}
	save_screen() {
		timedate="$(date +"%H:%M_%m-%d-%y")"
		grimblast save area ~/Pictures/screens/"$timedate".png
	}
	push_changes() {
		prevdir="$PWD"
		cd $HM_DIR
		git commit -a \
		&& git push \
		&& cd $prevdir
	}

# Alias
	alias nvim="neovide"
	alias win10on="sudo virsh start win10 && sudo virsh attach-device win10 $HOME/vmStorage/devices/headset.xml"
	alias win10off="sudo virsh shutdown win10 && sudo virsh detach-device win10 $HOME/vmStorage/devices/headset.xml"
	alias nvimtest="nvim $HM_DIR/dotfiles/nvim-init.lua -- -u $HM_DIR/dotfiles/nvim-init.lua"
	alias savescreen=save_screen
	alias serversend=send_to_server
	alias hmpush=push_changes
	source ~/.config/home-manager/dotfiles/.nixalias
