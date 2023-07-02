{ config, lib, pkgs, ... }:

let
  battery_warning = pkgs.writeShellScriptBin "battery_warning" ''
           while true
    		   do 
    			   connection_status=$(pamixer --list-sinks)
                   volume=$(pamixer --get-volume)
                   if [[ "$connection_status" = *"bluez"* ]];then 
    				   if [ $volume -gt 55 ];then 
    					   dunstify -a "VOLUME HIGH" "$volume" "GOSHUJIN SAMA TURN DOWN THE VOLUME" -i "~/.config/dunst/icon/angry.png" -u "critical" -t 45000
                    fi
                 fi
            sleep 3m
        done 
  '';

in

{
  home.packages = with pkgs; [
    battery_warning
  ];
}
