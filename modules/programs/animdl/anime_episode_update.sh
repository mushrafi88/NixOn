#!/usr/bin/env bash

# Directory to scan
ANIME_DOWNLOAD_FOLDER="$ANIME_DOWNLOAD_FOLDER"

# File to write
outfile="$ANIME_DOWNLOAD_FOLDER/episode.txt"

# Initialize the file if it does not exist
if [ ! -f "$outfile" ]; then
    touch "$outfile"
fi

# Iterate over all directories in ANIME_DOWNLOAD_FOLDER
while IFS=  read -r -d $'\0' dir; do
    # Extract directory name (removing leading ANIME_DOWNLOAD_FOLDER)
    dirname=${dir#$ANIME_DOWNLOAD_FOLDER/}

    # Skip if it's the parent directory itself
    if [ "$dirname" = "" ]; then
        continue
    fi

    # Find highest episode number in the directory
    highest_ep=$(find "$dir" -type f -name 'E*.mp4' -print0 | xargs -0 -n1 bash -c 'basename "$0" .mp4' | sed 's/E//' | sort -nr | head -n 1)

    # Continue if no episodes were found
    if [ -z "$highest_ep" ]; then
        continue
    fi

    # Get the last recorded episode for this series
    last_ep=$(grep "^$dirname " "$outfile" | awk '{print $NF}')

    # If the new episode is greater than the last recorded, or if it's a new series
    if [[ -z "$last_ep" || "$highest_ep" -gt "$last_ep" ]]; then
        # Write to the output file
        sed -i "/^$dirname /d" "$outfile"
        echo "$dirname $highest_ep" >> "$outfile"

        # Send a dunst notification
        dunstify "$dirname" "New episode $highest_ep" -i "~/.config/dunst/icon/love.png" -t 5000
    fi
done < <(find "$ANIME_DOWNLOAD_FOLDER" -type d -print0)
