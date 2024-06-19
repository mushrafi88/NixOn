{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default";
    devenv.url = "github:cachix/devenv";
    nixpkgs-python.url = "github:cachix/nixpkgs-python";
  };

  nixConfig = {
    extra-trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-substituters = "https://devenv.cachix.org";
  };

  outputs = { self, nixpkgs, devenv, systems, nixpkgs-python, ... } @ inputs:
    let
      forEachSystem = nixpkgs.lib.genAttrs (import systems);
    in
    {
      packages = forEachSystem (system: {
        devenv-up = self.devShells.${system}.default.config.procfileScript;
      });

      devShells = forEachSystem
        (system:
          let
            pkgs = nixpkgs.legacyPackages.${system};
          in
          {
            default = devenv.lib.mkShell {
              inherit inputs pkgs;
              modules = [
                {
                  # https://devenv.sh/reference/options/
                  packages = [
                   pkgs.stdenv.cc 
                   pkgs.gnumake
                   pkgs.glib 
                   pkgs.glibc
                   pkgs.manim
                   pkgs.python311Packages.pycairo
                   pkgs.python311Packages.manimpango

                   ]; # XXX pkgs?

                  languages.python = {
                    enable = true;
                    version = "3.11.3";
                    venv = {
                      enable = true;
                      quiet = true;
                    };
                      };
                  env.LD_LIBRARY_PATH = "${nixpkgs.lib.makeLibraryPath [ pkgs.stdenv.cc.cc.lib ]}:/run/opengl-driver/lib/:${nixpkgs.lib.makeLibraryPath [ pkgs.glib ]}";
                  enterShell = ''
                  pip install matplotlib numpy pandas tqdm jupyterlab imageio manim catppuccin-jupyterlab 
                  echo "##########################"
                  echo "##  Entering Direnv    ##"
                  echo "##########################"
                  zsh
                  '';
                  processes.myapp.exec = "";
                }
              ];
            };
          });
    };
}
