let
  pkgs = import <nixpkgs> { };
in
pkgs.mkShell {
  buildInputs = [
    pkgs.python312
    pkgs.python312.pkgs.pip
    pkgs.python312.pkgs.virtualenv
    pkgs.python312.pkgs.requests
    pkgs.python311.pkgs.beautifulsoup4
  ];
  shellHook = ''
                echo "Creating animdl_env"
                python -m venv $HOME/animdl/animdl_env
                source $HOME/animdl/animdl_env/bin/activate
                echo "Installing animdl"
                pip install -U animdl
            	bash $ANIME_DOWNLOAD_FOLDER/anime_dl_list.sh && 
    			exit
            	'';
}
