{ config, lib, pkgs, ... }:

{
  imports =
    [ ./cava-internal.nix ] ++
    [ ./myswaylock.nix ] ++
    [ ./launch_waybar.nix ] ++
    [ ./wallpaper.nix ] ++
    [ ./volume_high.nix ] ++
    [ ./battery_warning.nix ] ++
    [ ./bluetooth_headphone.nix ] ++
    [ ./yt_music.nix ] ++
    [ ./animdl.nix ] ++
    [ ./todo.nix ];
}
