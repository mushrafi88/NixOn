{ lib, pkgs, user, ... }:

{
  programs = {
    mpv = {
      enable = true;
    };
  };
  home.file.".config/mpv/mpv.conf".source = ./mpv.conf;
  home.file.".config/mpv/input.conf".source = ./input.conf;
  home.file.".config/mpv/scripts/file-browser.lua".source = ./scripts/file-browser.lua;
  home.file.".config/mpv/scripts/mpvhistory.lua".source = ./scripts/mpvhistory.lua;
  home.file.".config/mpv/scripts/nextfile.lua".source = ./scripts/nextfile.lua;
}
