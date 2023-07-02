{ config, lib, pkgs, ... }:

let
  bluetooth_headphone = pkgs.writeShellScriptBin "bluetooth_headphone" ''
              bluetoothctl power on 
    		  CONNECTED=$(bluetoothctl -- info B4:9A:95:A3:D8:7A | grep "Connected" | awk '{print $NF}')
    		  if [ "$CONNECTED" = "no" ];then 
    			  bluetoothctl connect B4:9A:95:A3:D8:7A 
                  N_CONNECTED=$(bluetoothctl -- info B4:9A:95:A3:D8:7A | grep "Connected" | awk '{print $NF}')
                  if [ "$N_CONNECTED" = "no" ];then 
    				  dunstify "Bluetooth Headphone" "Connection Failed" -i "~/.config/dunst/icon/confused.jpg" -t 5000
                 else  
    				 dunstify "Bluetooth Headphone" "Realme Buds 2 Connected" -i "~/.config/dunst/icon/love.png" -t 5000 
                fi 
            else 
    			bluetoothctl disconnect B4:9A:95:A3:D8:7A &
                dunstify "Bluetooth Headphone" "Realme buds 2 Disconnected" -i "~/.config/dunst/icon/sad.png" -t 5000 &
                bluetoothctl power off 
    		fi 
  '';

in

{
  home.packages = with pkgs; [
    bluetooth_headphone
  ];
}
