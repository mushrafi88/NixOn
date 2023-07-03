{ config, lib, pkgs, ... }:

let
  battery_warning = pkgs.writeShellScriptBin "battery_warning" ''
              while true 
    			  do   
    				  state=$(acpi | awk '{print $3}' | sed "s/,//g")
                      level=$(acpi | awk '{print $4}' | sed "s/[^0-9]//g")
                      if [[ ($level -lt 40) && ($state == "Discharging") ]]  
    					  then  
    					  dunstify -a "Battery" "Battery : $level %" " GOSHUJIN SAMA CONNECT TO AC" -i "~/.config/dunst/icon/angry.png" -u "critical" -t 45000 
                      fi
             sleep 6m
            done  
  '';

in

{
  home.packages = with pkgs; [
    battery_warning
  ];
}
