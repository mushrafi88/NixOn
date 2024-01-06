let
  pkgs = import <nixpkgs-unstable> { };
in
pkgs.mkShell {
  buildInputs = [
    pkgs.ani-cli
    pkgs.aria
  ];
  shellHook = ''
                echo "Downloading weekly ongoing anime" 

            	bash $HOME/.config/animdl/anime_dl_list.sh && 
    			exit
            	'';
}
