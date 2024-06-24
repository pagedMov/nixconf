# my NixOS config
This is my NixOS configuration. Feel free to use it, or take inspiration from it.

# Main Points
* Uses Hyprland as the desktop environment and window manager. 
* Designed to be modular. Contains the base config, and modules for machine-specific settings. This allows me to have system-specific settings that won't break my installations on my other machines when I push to this repo, and allows me to have a master configuration that is synced across all of my machines.
* Streamlines a lot of the tedium associated with using NixOS - aliases for easily and quickly installing packages, accessing config files from anywhere, and rebuilding the system, among others
* System config works out of the box for most tasks, and makes it easy to extend the functionality

If you feel like using this as a starting point for your own system, do 'nixhelp' for a list and description of each of my NixOS-related aliases, and 'aliashelp' for my general purpose aliases.
