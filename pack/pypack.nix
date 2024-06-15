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
  ]);
in
{
  inherit pythonWithPackages;
}
