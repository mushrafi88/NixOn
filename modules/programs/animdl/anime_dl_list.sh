#!/usr/bin/env bash

# Define the list of anime series
declare -A anime_series=(
    ["frieren"]="sousou no frieren"
    ["kusuriya"]="kusuriya no hitorigoto"
    ["mahou"]="mahou shoujo ni akogarete"
    ["slave"]="Mato Seihei no Slave"
    ["michibiku"]="Tsuki ga Michibiku Isekai Douchuu 2nd Season"
    ["exorcist"]="Ao no Exorcist: Shimane Illuminati-hen"
    ["tomozaki"]="Jaku-Chara Tomozaki-kun 2nd STAGE"
)

file="$ANIME_DOWNLOAD_FOLDER/episode.txt"

# Process each anime series
for key in "${!anime_series[@]}"; do
    anime_name="${anime_series[$key]}"
    anime_num=$(cat "$file" | grep -iE "$key" | tr -d '\n' | tail -n 1 | awk '{print $NF}')
    if ! [[ $anime_num =~ ^[0-9]+$ ]]; then 
        echo "Error: Non-numeric value found: $anime_num"
        # Handle error or continue to next iteration
        continue
    fi 
    anime_num=$((10#$anime_num + 1))
    echo "Checking for new episodes for ${anime_name}"
    $HOME/.config/animdl/ani-cli -d -e "$anime_num" "$anime_name"
done

bash $HOME/.config/animdl/anime_episode_update.sh
