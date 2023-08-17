{ pkgs ? import <nixpkgs> { } }:
let
  fhs = pkgs.buildFHSUserEnv {
    name = "My DL environment";

    targetPkgs = pkgs: with pkgs; [
      git
      gitRepo
      gnupg
      autoconf
      curl
      procps
      gnumake
      util-linux
      m4
      gperf
      unzip
      cudatoolkit
      linuxPackages.nvidia_x11
      libGLU
      libGL
      xorg.libXi
      xorg.libXmu
      freeglut
      xorg.libXext
      xorg.libX11
      xorg.libXv
      xorg.libXrandr
      zlib
      ncurses5
      stdenv.cc
      binutils
      micromamba
    ];
    multiPkgs = pkgs: with pkgs; [ zlib ];
    runScript = "bash";
    profile = ''
            set -e
      	   export CUDA_PATH=${pkgs.cudatoolkit}
            # export LD_LIBRARY_PATH=${pkgs.linuxPackages.nvidia_x11}/lib
            export EXTRA_LDFLAGS="-L/lib -L${pkgs.linuxPackages.nvidia_x11}/lib"
            export EXTRA_CCFLAGS="-I/usr/include"
            export MAMBA_ROOT_PREFIX=${builtins.getEnv "PWD"}/.mamba
            eval "$(micromamba shell hook --shell=bash | sed 's/complete / # complete/g')"
            #micromamba create --yes -q -n mambo_jambo
            micromamba activate mambo_jambo 
            set +e
    '';


  };
in
fhs.env
