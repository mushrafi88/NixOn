{ lib, pkgs, user, ... }:
{
  programs.ags = {
    enable = true;
    #configDir = ./ags; 
    extraPackages = with pkgs; [ 
    gtksourceview 
    webkitgtk_4_0 
    accountsservice 
    ];
  };
}
