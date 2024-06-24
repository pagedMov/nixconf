{ config, lib, pkgs, ... }:

# Use this file to define machine-specific settings
# Rename to "hardware-specific.nix" when you have made your changes
{
	environment.systemPackages = with pkgs; [ # Hardware specific packages
	];
}
