{ config, lib, pkgs, inputs, ... }:
{
  imports = [ ../waybar/hyprland_waybar.nix ];
  programs = {
    dconf.enable = true;
    light.enable = true;
  };

  environment.systemPackages = with pkgs; [
    grimblast
    hyprpicker
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
