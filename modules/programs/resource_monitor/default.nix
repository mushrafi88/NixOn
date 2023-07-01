{ config, pkgs, ... }:
{
  programs = {
    btop = {
      enable = true;
    };
    htop = {
      enable = true;
    };
  };
}
