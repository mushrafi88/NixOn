#!/usr/bin/env bash

# Define the path to the JSON file
JSON_FILE="$ANIME_DOWNLOAD_FOLDER/anime_episodes.json"

# Loop through each anime series in the JSON file
for key in $(jq -r '.anime_series | keys[]' "$JSON_FILE"); do
    anime_name=$(jq -r ".anime_series[\"$key\"].title" "$JSON_FILE")
    echo "$anime_name"
    anime_num=$(jq -r ".anime_series[\"$key\"].episodes" "$JSON_FILE")
    echo "$anime_num"
    episode=$((anime_num + 1))
    echo "$episode"
    # Download the episode
    poetry run python /mnt/research/anipy-cli/cli/src/anipy_cli/cli.py -D -s '"$anime_name":"$episode":sub' 
    #"$HOME/.config/animdl/ani-cli" -d -e "$episode" "$anime_name"
 
    # Check if the anime folder exists
    if [ -d "$ANIME_DOWNLOAD_FOLDER/$anime_name" ]; then
        # Find the highest episode number available in the anime folder
        highest_episode=$(find "$ANIME_DOWNLOAD_FOLDER/$anime_name" -type f -name 'Episode *.ts' | sed -nE 's|.*/Episode ([0-9]+)\.ts$|\1|p' | sort -nr | head -n1)
        if [ -n "$highest_episode" ]; then
            # Compare the highest episode number with the current episode number
            if [ "$highest_episode" -gt "$anime_num" ]; then
                # Update the JSON file entry
                jq --arg key "$key" --arg highest_episode "$highest_episode" '.anime_series[$key].episodes = $highest_episode' "$JSON_FILE" > tmp.json && mv tmp.json "$JSON_FILE"
                echo "Episode $highest_episode of $anime_name downloaded successfully."
                dunstify "$anime_name" "New episode $highest_episode available" -i "$HOME/.config/dunst/icon/love.png" -t 5000
            else
                echo "No new episodes available for $anime_name."
            fi
        else
            echo "No episodes found for $anime_name."
        fi
    else
        echo "Anime folder not found for $anime_name."
    fi
done

