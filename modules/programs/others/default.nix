{ config, lib, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      rofi-wayland
      texlive.combined.scheme-full
      lazygit
      nitch
      pass
      pcmanfm
      gtk-engine-murrine
      stremio
      libreoffice-fresh
    ];
  };
}
