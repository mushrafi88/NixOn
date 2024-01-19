{ config, lib, pkgs, user, impermanence, inputs, ... }:

{
  imports =
    [ (import ../../modules/desktop/hyprland/home.nix) ] ++
    [ (import ../../modules/scripts) ] ++
    (import ../../modules/shell) ++
    (import ../../modules/editors) ++
    (import ../../modules/programs) ++
    (import ../../modules/theme);

  home = {
    username = "venerable_white";
    homeDirectory = "/home/venerable_white";
  };
  programs = {
    home-manager.enable = true;
  };

  home.stateVersion = "24.05";
  home.language.base = "en_US.UTF-8";
}
