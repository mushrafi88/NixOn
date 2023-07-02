{ config, lib, pkgs, ... }:

{
  imports =
    [ ./cava-internal.nix ] ++
    [ ./grimblast.nix ] ++
    [ ./flameshot_watermark.nix ] ++
    [ ./myswaylock.nix ] ++
    [ ./launch_waybar.nix ] ++
    [ ./border_color.nix ] ++
    [ ./wallpaper.nix ];
}
