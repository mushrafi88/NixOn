#!/usr/bin/env bash

file_list="$HOME/Pictures/wallpapers/live_wallpapers/playlist.txt"

if [ ! -f "$file_list" ]; then
    echo "File list not found: $file_list"
    exit 1
fi

video_files=($(cat "$file_list"))

if [ ${#video_files[@]} -eq 0 ]; then
    echo "No video files found in the list."
    exit 1
fi

shuffled_video_files=($(shuf -e "${video_files[@]}"))
random_video="${shuffled_video_files[1]}"

pkill mpvpaper
mpvpaper -vs -o "no-audio loop" eDP-1 $HOME/Pictures/wallpapers/live_wallpapers/"$random_video"
