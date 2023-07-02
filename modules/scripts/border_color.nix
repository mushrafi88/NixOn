{ config, lib, pkgs, ... }:

let
  border_color = pkgs.writeShellScriptBin "border_color" ''
      function border_color {
      hyprctl keyword general:col.active_border rgb\(ffc0cb\) 
    }
    socat - UNIX-CONNECT:/tmp/hypr/$(echo $HYPRLAND_INSTANCE_SIGNATURE)/.socket2.sock | while read line; do border_color $line; done
  '';


in

{
  home.packages = with pkgs; [
    border_color
  ];
}
