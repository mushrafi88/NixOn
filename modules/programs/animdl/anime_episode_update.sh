#!/usr/bin/env bash

# File to write
outfile="$ANIME_DOWNLOAD_FOLDER/episode.txt"

# Initialize the file if it does not exist
if [ ! -f "$outfile" ]; then
    touch "$outfile"
fi

# Iterate over all directories in ANIME_DOWNLOAD_FOLDER
find "$ANIME_DOWNLOAD_FOLDER" -type d -print0 | while IFS= read -r -d $'\0' dir; do
    # Extract directory name (removing leading ANIME_DOWNLOAD_FOLDER)
    dirname=${dir#$ANIME_DOWNLOAD_FOLDER/}

    # Skip if it's the parent directory itself
    if [ -z "$dirname" ]; then
        continue
    fi

    # Find highest episode number in the directory
    highest_ep=$(find "$dir" -maxdepth 1 -type f \( -name 'Episode *.mp4' -o -name 'E*.mp4' \) \
            | sed -n 's/.*Episode \?\([0-9]\+\)\.mp4/\1/p' \
        | sort -n | tail -n 1)

    # Continue if no episodes were found
    if [ -z "$highest_ep" ]; then
        continue
    fi

    # Get the last recorded episode for this series
    last_ep=$(grep "^$dirname " "$outfile" | awk '{print $NF}')

    # If the new episode is greater than the last recorded, or if it's a new series
    if [[ -z "$last_ep" || ${highest_ep#0} -gt ${last_ep#0} ]]; then
        # Write to the output file
        sed -i "/^$dirname /d" "$outfile"
        echo "$dirname $highest_ep" >> "$outfile"

        # Send a dunst notification
        dunstify "$dirname" "New episode $highest_ep" -i "~/.config/dunst/icon/love.png" -t 5000
    fi
done
