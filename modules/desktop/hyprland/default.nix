{ config, lib, pkgs, inputs, ... }:
{
  imports = [ ../waybar/hyprland_waybar.nix ];
  programs = {
    dconf.enable = true;
    light.enable = true;
  };

  environment.systemPackages = with pkgs; [
    inputs.hypr-contrib.packages.${pkgs.system}.grimblast
    inputs.hyprpicker.packages.${pkgs.system}.hyprpicker
    swaylock-effects
    pamixer
  ];

  security.pam.services.swaylock = { };

  xdg.portal.config.common.default = "*";

  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

}
