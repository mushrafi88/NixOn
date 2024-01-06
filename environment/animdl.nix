let
  pkgs = import <nixpkgs-unstable> { };
in
pkgs.mkShell {
  buildInputs = [
    pkgs.ani-cli
    pkgs.aria
  ];
  shellHook = ''
    					zsh
                    	'';
}
