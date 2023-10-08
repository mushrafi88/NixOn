{ config, lib, pkgs, user, ... }:

{
  environment.systemPackages = with pkgs; [
    waybar
  ];

  home-manager.users.venerable_white = {
    # Home-manager waybar config
    programs.waybar = {
      enable = true;
      systemd = {
        enable = false;
        target = "graphical-session.target";
      };
    };
  };
}
