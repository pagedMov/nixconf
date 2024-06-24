{ pkgs }:

let
  pythonWithPackages = pkgs.python311.withPackages (ps: with ps; [
    pandas
    tkinter
    matplotlib
    beautifulsoup4
    requests
    bokeh
    plotly
    seaborn
    watchdog
    pillow
    cairosvg
    openpyxl
	flake8
	discordpy
	scipy
	simple-websocket-server
    pynotifier
    python-daemon
    flask
    nltk
  ]);
in
{
  inherit pythonWithPackages;
}
