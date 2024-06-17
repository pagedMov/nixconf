# Environment variables
	export PATH="/home/shade/bin:$PATH"
	export PS1="\n\[\033[1;38;2;176;0;176m\][\[\e]0;\u@\h: \w\a\]\u@\h:\w]\$ \[\033[0m\]"
	export EDITOR="nvim"
	export NVIM_CONFIG="/home/shade/.config/nvim/init.lua"
	export BASHRC="/home/shade/.config/home-manager/dotfiles/.bashrc"
	export HYPRCONF="/home/shade/.config/home-manager/dotfiles/hyprland.conf"
	export HM_DIR="/home/shade/.config/home-manager"
	export DOTFILES="/home/shade/.config/home-manager/dotfiles"
	export SYSD_DIR="/home/shade/.config/systemd/user"

# Alias
	source /home/shade/.nixalias
	alias win10on="sudo virsh start win10 && sudo virsh attach-device win10 /home/shade/vmStorage/devices/headset.xml"
	alias win10off="sudo virsh shutdown win10 && sudo virsh detach-device win10 /home/shade/vmStorage/devices/headset.xml"
	alias nvimtest="nvim -u $HM_DIR/dotfiles/nvim-init.lua $HM_DIR/dotfiles/nvim-init.lua"
	alias savescreen="grimblast save area ~/Pictures/screens/\"$(date).png\""
