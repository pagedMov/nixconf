with import <nixpkgs> {};
let
  luaPackages = pkgs.luajitPackages;
  pythonPackages = pkgs.python312Packages;
  libs = [
  pythonPackages.websocket-client
  pythonPackages.websockets
  pythonPackages.aiohttp
  pythonPackages.pynvim
  pythonPackages.nest-asyncio
  luaPackages.luasocket
  luaPackages.luasec
  ];
in
pkgs.mkShell {
  buildInputs = [
    pkgs.python312
    pkgs.lua5_3
  ] ++ libs;

  shellHook = ''
  	export PYTHONPATH="$PWD:$PYTHONPATH"
  '';
}
