#!/usr/bin/env bash

# Define the list of anime series
declare -A anime_series=(
    ["michibiku"]="Tsuki ga Michibiku Isekai Douchuu 2nd Season"
    ["konosuba"]="Kono Subarashii Sekai ni Shukufuku wo! 3"
    ["mushoku_tensei"]="Mushoku Tensei II: Isekai Ittara Honki Dasu Part 2"
    ["wind_breaker"]="Wind Breaker"
    ["hananoi"]="Hananoi-kun to Koi no Yamai"
    ["slime"]="Tensei Shitara Slime Datta Ken 3rd Season"
    ["mahouka"]="Mahouka Koukou no Rettousei 3rd Season"
    ["maou_elf"]="Maou no Ore ga Dorei Elf wo Yome ni Shitanda ga, Dou Medereba Ii?"
    ["black_butler"]="Kuroshitsuji: Kishuku Gakkou-hen"
    ["kimetsu_no_yaiba"]="Kimetsu no Yaiba: Hashira Geiko-hen"
    ["kaiju_8"]="Kaijuu 8-gou"
    ["yozakura_fam"]="Yozakura-san Chi no Daisakusen"
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
