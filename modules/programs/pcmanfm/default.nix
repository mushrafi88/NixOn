{ config, lib, pkgs, ... }:

{
  home.packages = [
    pkgs.pcmanfm
    pkgs.gtk-engine-murrine
  ];
  # home.file.".config/neofetch/config.conf".text = import ./config.nix;
}
