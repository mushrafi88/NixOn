{ config, lib, pkgs, ... }:

{
  imports =
    [ ./cava-internal.nix ] ++
    [ ./myswaylock.nix ] ++
    [ ./launch_waybar.nix ] ++
    [ ./wallpaper.nix ] ++
    [ ./volume_high.nix ] ++
    [ ./lfub.nix ] ++
    [ ./battery_warning.nix ] ++
    [ ./bluetooth_headphone.nix ];
}
