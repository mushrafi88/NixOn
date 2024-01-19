{ config, lib, pkgs, ... }:

let
  bluetooth_headphone = pkgs.writeShellScriptBin "bluetooth_headphone" ''
        #bluetoothctl power on 
    	DEVICE_MAC="28:04:C6:47:46:A4"

# Function to check the connection status
function is_connected {
    bluetoothctl info "$DEVICE_MAC" | grep "Connected" | awk '{print $NF}'
}

# Disconnect all existing connections to the device
while [ "$(is_connected)" = "yes" ]; do
    bluetoothctl disconnect "$DEVICE_MAC"
    sleep 1
done

# Attempt to connect to the device
bluetoothctl connect "$DEVICE_MAC"

# Wait for a few seconds to allow the connection to establish
sleep 3

# Check the new connection status
if [ "$(is_connected)" = "yes" ]; then
    dunstify "Bluetooth Headphone" "HONOR AM61 Connected" -i "~/.config/dunst/icon/love.jpg" -t 5000
else
    dunstify "Bluetooth Headphone" "Connection failed" -i "~/.config/dunst/icon/confused.jpg" -t 5000
fi
  '';

in

{
  home.packages = with pkgs; [
    bluetooth_headphone
  ];
}
