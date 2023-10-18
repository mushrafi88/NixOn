{ config, lib, pkgs, ... }:

let
  wallpaper_folder = pkgs.writeShellScriptBin "wallpaper_folder" '' 
      options="dark bright mild ALL"
      selected_folder=$(printf '%s\n' $options | rofi -dmenu -p "Please choose a wallpaper Folder:" -theme ~/.config/rofi/drun_theme.rasi)
      echo "$selected_folder" > $HOME/selected_folder.txt
      pkill -f wallpaper_process 
      pkill mpvpaper
      rm -f /tmp/wallpaper_process.lock
      wallpaper_process &
  '';
  wallpaper_start = pkgs.writeShellScriptBin "wallpaper_start" ''
        sleep 600
        echo dark > $HOME/selected_folder.txt
        pkill -f wallpaper_process 
    	pkill mpvpaper
        rm -f /tmp/wallpaper_process.lock
        wallpaper_process &
  '';
  wallpaper_next = pkgs.writeShellScriptBin "wallpaper_next" '' 
  lock_file="/tmp/wallpaper_process.lock" 
  pkill mpvpaper
  if [ -e "$lock_file" ]; then 
	  kill -USR1 $(cat "$lock_file")
  else 
	  echo "set_wallpaper.sh is not running."
  fi
'';
  wallpaper_prev = pkgs.writeShellScriptBin "wallpaper_prev" '' 

  lock_file="/tmp/wallpaper_process.lock" 
  if [ -e "$lock_file" ]; then 
	  kill -USR2 $(cat "$lock_file")
  else 
	  echo "set_wallpaper.sh is not running."
  fi
'';
  wallpaper_process = pkgs.writeShellScriptBin "wallpaper_process" '' 

# Lock file
lock_file="/tmp/wallpaper_process.lock"

# Check if there's already a running instance
if [ -e "$lock_file" ]; then
  echo "wallpaper_process is already running."
  exit 0
fi

# Create lock file with the current process ID
echo $$ > "$lock_file"

# Function to set the selected folder and shuffle wallpapers
load_selected_folder() {
  selected_folder=$(cat $HOME/selected_folder.txt)
  echo "reading txt found $selected_folder"
  if [[ "$selected_folder" = "ALL" ]]; then
    selected_folder=$HOME/Pictures/wallpapers
  else
    selected_folder=$HOME/Pictures/wallpapers/"$selected_folder"
  fi
  echo "final selected_folder $selected_folder"
  shuffled_wallpapers=""

for file in $(find "$selected_folder" -type f \( -name '*.jpg' -o -name '*.jpeg' -o -name '*.png' \) | sort -R)
do
    shuffled_wallpapers="$shuffled_wallpapers$file\n"
done

printf "$shuffled_wallpapers"

 # shuffled_wallpapers=($(find "$selected_folder" -type f \( -name '*.jpg' -o -name '*.jpeg' -o -name '*.png' \) | shuf))
}

# Global variables
current_index=1
direction=1

# Functions for moving to the next or previous wallpaper
move_next() {
  direction=1
  current_index=$((current_index + direction))
}

move_previous() {
  direction=-1
  current_index=$((current_index + direction))
}

# Trap signals to move to the next or previous wallpaper
trap 'move_next' USR1
trap 'move_previous' USR2

# Load the initial selected folder and shuffle wallpapers
load_selected_folder

# Continuously set the wallpaper using feh
while true; do
  #echo "shuffled_wallpapers list $shuffled_wallpapers"
  #wallpaper="$shuffled_wallpapers["$current_index"]"
  wallpaper=$(printf "$shuffled_wallpapers" | awk -v idx=$current_index 'NR==idx')
  echo "selected_wallpaper location $wallpaper"
  swww img "$wallpaper" --transition-type random
  sleep 900 & # 5 minutes * 60 seconds
  wait $!
  current_index=$((current_index + direction))
done
'';

  live_wallpaper = pkgs.writeShellScriptBin "live_wallpaper" '' 
  file_list="$HOME/Pictures/wallpapers/live_wallpapers/playlist.txt"

if [ ! -f "$file_list" ]; then
    echo "File list not found: $file_list"
    exit 1
fi

  video_files=$(cat "$file_list")

  random_video=$(shuf -n 1 -e $video_files)

  pkill mpvpaper 
  mpvpaper -vs -o "no-audio loop" eDP-1 $HOME/Pictures/wallpapers/live_wallpapers/"$random_video"

'';
in

{
  home.packages = with pkgs; [
    wallpaper_process
    wallpaper_next
    wallpaper_prev
    wallpaper_folder
    wallpaper_start
    live_wallpaper
  ];
}
