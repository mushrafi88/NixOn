{ config, lib, pkgs, ... }:

let
  bluetooth_headphone = pkgs.writeShellScriptBin "bluetooth_headphone" ''
device_address="2C:BE:EB:C3:2B:1D"

connection_status=$(bluetoothctl info $device_address | grep "Connected:" | awk '{print $2}')

if [ "$connection_status" == "yes" ]; then
  status="connected"
else
  status="disconnected"
fi

echo "Device $device_address is currently $status"

if [ "$connection_status" == "yes" ]; then
  echo "Disconnecting from $device_address..."
  status="disconnected"
  bluetoothctl << EOF
  disconnect $device_address
EOF
else
  echo "Connecting to $device_address..."
  status="connected"
  bluetoothctl << EOF
  connect $device_address
EOF
fi'';

in

{
  home.packages = with pkgs; [
    bluetooth_headphone
  ];
}
