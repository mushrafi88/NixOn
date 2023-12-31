{ config, lib, pkgs, ... }:

let
  bluetooth_headphone = pkgs.writeShellScriptBin "bluetooth_headphone" ''
              bluetoothctl power on 
    		  CONNECTED=$(bluetoothctl -- info 28:04:C6:47:46:A4 | grep "Connected" | awk '{print $NF}')
    		  if [ "$CONNECTED" = "no" ];then 
    			  bluetoothctl connect 28:04:C6:47:46:A4
                  N_CONNECTED=$(bluetoothctl -- info 28:04:C6:47:46:A4 | grep "Connected" | awk '{print $NF}')
                  if [ "$N_CONNECTED" = "no" ];then 
    				  dunstify "Bluetooth Headphone" "Connection Failed" -i "~/.config/dunst/icon/confused.jpg" -t 5000
                 else  
    				 dunstify "Bluetooth Headphone" "Realme Buds 2 Connected" -i "~/.config/dunst/icon/love.png" -t 5000 
                fi 
            else 
    			bluetoothctl disconnect 28:04:C6:47:46:A4 &
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
