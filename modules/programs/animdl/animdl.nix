let
  pkgs = import <nixpkgs-unstable> { };
in
pkgs.mkShell {
  buildInputs = [
    pkgs.python311
    pkgs.python311.pkgs.pip
    pkgs.python311.pkgs.virtualenv
    pkgs.python311.pkgs.requests
    pkgs.python311.pkgs.beautifulsoup4
    pkgs.animdl
  ];
  shellHook = ''
                sh $ANIME_DOWNLOAD_FOLDER/anime_dl_list.sh && 
    			exit
            	'';
}
