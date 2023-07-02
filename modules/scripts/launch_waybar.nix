{ config, lib, pkgs, ... }:

let
  launch_waybar = pkgs.writeShellScriptBin "launch_waybar" ''
        #!/bin/bash
        killall .waybar-wrapped
        SDIR="$HOME/.config/waybar"
    	waybar -c "$SDIR"/config -s "$SDIR"/style.css > /dev/null 2>&1 & 
  '';

in

{
  home.packages = with pkgs; [
    launch_waybar
  ];
}
