{ config, lib, pkgs, ... }:

{
  home.packages = [ pkgs.transmission_4-gtk ];
  #  home.file.".config/sioyek".source = ./config;
}
