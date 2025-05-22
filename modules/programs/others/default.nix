{ config, lib, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      rofi-wayland
      texlive.combined.scheme-full
      lazygit
      yafetch
      pass
      pcmanfm
      gtk-engine-murrine
      stremio
      libreoffice-fresh
      micromamba
      brave
      calcurse
      inkscape-with-extensions
      ghostscript_headless
      zoom-us 
    ];
  };
}
