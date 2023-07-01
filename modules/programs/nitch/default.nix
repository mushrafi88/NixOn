{ config, lib, pkgs, ... }:

{
  home.packages = [ pkgs.nitch ];
  #home.file.".config/neofetch/config.conf".text = import ./config.nix;
}
