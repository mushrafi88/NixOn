{ config, lib, pkgs, ... }:

{
  home.packages = [ pkgs.swayimg ];
  #home.file.".config/sioyek".source = ./config;
}
