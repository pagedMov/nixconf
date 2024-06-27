{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    python312
    python312Packages.pandas
    python312Packages.numpy
    python312Packages.scipy
    python312Packages.matplotlib
    python312Packages.requests
    python312Packages.scikit-learn
    python312Packages.jupyter
    python312Packages.ipython
  ];

  # Optional: Set environment variables or add pre-commands here
  shellHook = ''
    echo "General purpose Python environment is ready!"
    # You can activate a virtual environment here if needed
  '';
}
