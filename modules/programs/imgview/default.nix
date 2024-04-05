{ config, lib, pkgs, ... }:

{
  home.packages = [ pkgs.swayimg ];
  home.file.".config/swayimg/config".source = ./config;
}
