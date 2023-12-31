{ pkgs ? import <nixpkgs> { } }:
let
  fhs = pkgs.buildFHSUserEnv {
    name = "sirv environment";

    targetPkgs = pkgs: with pkgs; [
      gnumake
      util-linux
      libGLU
      libGL
      zlib
      stdenv.cc
      binutils
      micromamba
    ];
    multiPkgs = pkgs: with pkgs; [ zlib ];
    runScript = "bash";
    profile = ''
                                set -e
                                export EXTRA_CCFLAGS="-I/usr/include"
                                export MAMBA_ROOT_PREFIX=${builtins.getEnv "PWD"}/.mamba
                                eval "$(micromamba shell hook --shell=bash | sed 's/complete / # complete/g')"

                  			  if ! micromamba env list | grep -q sirv_env;then 
                  				  micromamba create --yes -q -n sirv_env 
      							  micromamba activate sirv_env 
            					      micromamba install jupyter -c conda-forge
                                    pip install matplotlib pandas seaborn scikit-learn tqdm networkx
                        		      pip install mesa==1.2.1
                  			  else
                    micromamba activate sirv_env 

                  			                          fi
                                set +e
    '';
  };
in
fhs.env
