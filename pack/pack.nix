{ pkgs, ... }:

let
  homePkgs = import /home/shade/.config/home-manager/pack/homepack.nix { inherit pkgs; };
  pythonWithPackages = import /home/shade/.config/home-manager/pack/pypack.nix { inherit pkgs; };
  fontPackages = import /home/shade/.config/home-manager/pack/fontpack.nix { inherit pkgs; };
in { homePack = with pkgs; pythonWithPackages ++ fontPackages ++ homePkgs; }
