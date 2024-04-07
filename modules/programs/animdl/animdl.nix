let
  pkgs = import <nixpkgs> { };
in
pkgs.mkShell {
  buildInputs = [
    pkgs.python311
    pkgs.python311Packages.types-beautifulsoup4
    pkgs.python311Packages.requests
    pkgs.ani-cli
    pkgs.aria
  ];
  shellHook = ''
                echo "Downloading weekly ongoing anime" 

            	bash $HOME/.config/animdl/anime_dl_list.sh && 
    			exit
            	'';
}
