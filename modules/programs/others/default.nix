{ config, lib, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      rofi-wayland
      texlive.combined.scheme-full
      lazygit
      pfetch
      pass
      pcmanfm
      gtk-engine-murrine
      stremio
      libreoffice-fresh
      micromamba
      brave
      calcurse
    ];
  };
}
