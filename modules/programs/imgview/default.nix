{ config, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      imv
    ];
    file.".config/imv/config".source = ./config;
  };
}
