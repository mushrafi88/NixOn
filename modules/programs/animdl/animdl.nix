let
  pkgs = import <nixpkgs> { };
in
pkgs.mkShell {
  buildInputs = [
    pkgs.python311
    pkgs.python311.pkgs.pip
    pkgs.python311.pkgs.virtualenv
    pkgs.python311.pkgs.requests
  ];
  shellHook = ''
            echo "Creating animdl_env"
            python3 -m venv $HOME/.config/animdl/animdl_env
            source $HOME/.config/animdl/animdl_env/bin/activate
            echo "Updating pip"
            pip install --upgrade pip 
            echo "Installing animdl"
            pip install animdl
    		pip install bs4
        	bash $HOME/.config/animdl/anime_dl_list.sh 
        	'';
}
