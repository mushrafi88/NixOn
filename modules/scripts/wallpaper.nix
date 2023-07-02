{ config, lib, pkgs, ... }:

let
  default_wall = pkgs.writeShellScriptBin "default_wall" ''
    if command -v swww >/dev/null 2>&1; then 
          killall dynamic_wallpaper
           if [[ "$GTK_THEME" == "Catppuccin-Frappe-Pink" ]]; then
             swww img "${../theme/catppuccin-dark/common/wall/default.png}" --transition-type random 
           fi
    elif command -v swaybg >/dev/null 2>&1; then 
        killall swaybg
        killall dynamic_wallpaper
        if [[ "$GTK_THEME" == "Catppuccin-Frappe-Pink" ]]; then
          swaybg -i "${../theme/catppuccin-dark/common/wall/default.png}" -m fill &
        fi
    else 
        killall feh
        killall dynamic_wallpaper
        if [[ "$GTK_THEME" == "Catppuccin-Frappe-Pink" ]]; then
          feh --randomize --bg-fill "${../theme/catppuccin-dark/common/wall/default.png}" &
        fi
    fi
  '';
  wallpaper_random = pkgs.writeShellScriptBin "wallpaper_random" ''
    if command -v swww >/dev/null 2>&1; then 
        killall dynamic_wallpaper
        swww img $(find ~/pictures/wallpaper/. -name "*.png" | shuf -n1) --transition-type random
    else 
        killall swaybg
        killall dynamic_wallpaper
        swaybg -i $(find ~/pictures/wallpaper/. -name "*.png" | shuf -n1) -m fill &
    fi
  '';

  dynamic_wallpaper = pkgs.writeShellScriptBin "dynamic_wallpaper" ''
    if command -v swww >/dev/null 2>&1; then 
        swww img $(find ~/Pictures/wallpaper/. -name "*.png" | shuf -n1) --transition-type random
        OLD_PID=$!
        while true; do
            sleep 15
        swww img $(find ~/Pictures/wallpaper/. -name "*.png" | shuf -n1) --transition-type random
            NEXT_PID=$!
            sleep 5
            kill $OLD_PID
            OLD_PID=$NEXT_PID
        done
    elif command -v swaybg >/dev/null 2>&1; then  
        killall swaybg
        swaybg -i $(find ~/Pictures/wallpaper/. -name "*.png" | shuf -n1) -m fill &
        OLD_PID=$!
        while true; do
            sleep 120
            swaybg -i $(find ~/Pictures/wallpaper/. -name "*.png" | shuf -n1) -m fill &
            NEXT_PID=$!
            sleep 5
            kill $OLD_PID
            OLD_PID=$NEXT_PID
        done
    else 
        killall feh 
        feh --randomize --bg-fill $(find ~/Pictures/wallpaper/. -name "*.png" | shuf -n1) &
        OLD_PID=$!
        while true; do
            sleep 120
            feh --randomize --bg-fill $(find ~/Pictures/wallpaper/. -name "*.png" | shuf -n1) &
            NEXT_PID=$!
            sleep 5
            kill $OLD_PID
            OLD_PID=$NEXT_PID
        done
    fi
  '';
in

{
  home.packages = with pkgs; [
    default_wall
    wallpaper_random
    dynamic_wallpaper
  ];
}
