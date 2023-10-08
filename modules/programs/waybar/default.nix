{ pkgs, config, ... }:
{
  home.file.".config/waybar".source = ./config;
}
