with import <nixpkgs> {};
with luaPackages;
let
	libs = [
	luasocket luasec
	];
	luapack = lua.withPackages(ps: with ps; libs);
in
stdenv.mkDerivation rec {
  name = "lua-env";
  buildInputs = [ luapack ];

	shellHook = ''
		export LUA_CPATH="${lib.concatStringsSep ";" (map getLuaCPath libs)}"
		export LUA_PATH="${lib.concatStringsSep ";" (map getLuaPath libs)}"
	'';
}
