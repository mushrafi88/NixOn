{ config, lib, pkgs, ... }:

let
  bluetooth_headphone = pkgs.writeShellScriptBin "bluetooth_headphone" ''
        #bluetoothctl power on 
    		CONNECTED=$(bluetoothctl -- info 28:04:C6:47:46:A4 | grep "Connected" | awk '{print $NF}')
    		if [ "$CONNECTED" = "no" ];then 
    			bluetoothctl connect 28:04:C6:47:46:A4
          N_CONNECTED=$(bluetoothctl -- info 28:04:C6:47:46:A4 | grep "Connected" | awk '{print $NF}') 
          wait 3s 
           if [ "$N_CONNECTED" = "yes" ];then 
    				 dunstify "Bluetooth Headphone" "HONOR AM61 Connected" -i "~/.config/dunst/icon/love.jpg" -t 5000
            else 
    			  dunstify "Bluetooth Headphone" "Connection failed" -i "~/.config/dunst/icon/confused.jpg" -t 5000 
            fi 
          else 
    			bluetoothctl disconnect 28:04:C6:47:46:A4 & wait 3s &
            dunstify "Bluetooth Headphone" "HONOR AM61 Disconnected" -i "~/.config/dunst/icon/sad.png" -t 5000 
    		fi
  '';

in

{
  home.packages = with pkgs; [
    bluetooth_headphone
  ];
}
