{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
	stylix.url = "github:danth/stylix";
  };

  outputs = { self, nixpkgs, stylix, ...}: {
	nixosConfigurations.HAUNTER = nixpkgs.lib.nixosSystem {
		system = "x86_64-linux";
		modules = [ stylix.nixosModules.stylix ./configuration.nix ];
	};
  };
}
