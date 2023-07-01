{ config, lib, pkgs, ... }:

{
  home.packages = [ pkgs.sioyek ];
  home.file.".config/sioyek".source = ./config;
}
