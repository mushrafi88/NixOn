{ config, lib, pkgs, ... }:

{
  home.packages = [ pkgs.transmission-gtk ];
  #  home.file.".config/sioyek".source = ./config;
}
