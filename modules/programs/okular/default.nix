{ config, lib, pkgs, ... }:

{
  home.packages = [ pkgs.libsForQt5.okular ];
  #home.file.".config/sioyek".source = ./config;
}
