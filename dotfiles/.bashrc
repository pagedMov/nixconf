# Environment variables
	export PATH="/home/shade/bin:$PATH"
	export PS1="\n\[\033[1;38;2;176;0;176m\][\[\e]0;\u@\h: \w\a\]\u@\h:\w]\$ \[\033[0m\]"
	export EDITOR="neovide"
	export NVIM_CONFIG="/home/shade/.config/nvim/init.lua"
	export BASHRC="/home/shade/.config/home-manager/dotfiles/.bashrc"
	export HYPRCONF="/home/shade/.config/home-manager/dotfiles/hyprland.conf"
	export HM_DIR="/home/shade/.config/home-manager"
	export NIX_DIR="/etc/nixos"
	export DOTFILES="/home/shade/.config/home-manager/dotfiles"
	export SYSD_DIR="/home/shade/.config/systemd/user"
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

# Alias
	alias nvim="neovide"
	alias win10on="sudo virsh start win10 && sudo virsh attach-device win10 /home/shade/vmStorage/devices/headset.xml"
	alias win10off="sudo virsh shutdown win10 && sudo virsh detach-device win10 /home/shade/vmStorage/devices/headset.xml"
	alias nvimtest="nvim $HM_DIR/dotfiles/nvim-init.lua -- -u $HM_DIR/dotfiles/nvim-init.lua"
	alias savescreen="grimblast save area ~/Pictures/screens/\"$(date).png\""
	alias serversend=send_to_server
	source /home/shade/.config/home-manager/dotfiles/.nixalias
