{ config, lib, pkgs, ... }:

{
  imports =
    [ ./cava-internal.nix ] ++
    [ ./myswaylock.nix ] ++
    [ ./launch_waybar.nix ] ++
    [ ./wallpaper.nix ] ++
    [ ./volume_warning.nix ] ++
    [ ./battery_warning.nix ] ++
    [ ./bluetooth_headphone.nix ] ++
    [ ./yt_music.nix ] ++
    [ ./animdl.nix ] ++
    [ ./snippets_cp.nix ] ++
    [ ./todo.nix ];
}
