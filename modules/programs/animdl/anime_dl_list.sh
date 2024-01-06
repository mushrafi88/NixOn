#!/usr/bin/env bash

#youtube dl
#yt-q best -dlp -f 'bestvideo[height=1080]+bestaudio/best' --write-sub --embed-subs --yes-playlist -o "/home/venerable_white/Videos/Anime/Airing/by_the_grace_of_god/%(title)s.%(ext)s" --download-archive dl.txt 'https://www.youtube.com/playlist?list=PLxSscENEp7JgZhNUrkpwoksoSLEmTqB6U'

#anime downlader-vnki
#anime dl -c 18 -p animerush -e $((1+$(cat /run/media_m/Anime/Airing/isekai_ojisan/episode.txt))): --q best -download-dir /run/media_m/Anime/Airing/isekai_ojisan 'Isekai Ojisan'

# sources for animdl - animeout, animepahe, kawaiifu, marin, zoro, gogoanime, haho
#
#the dangers in my heart
#animdl download "animepahe:The dangers in my heart" -q best -d /run/media/media_m/Anime/Airing/ --index 1 -r $((1+$(cat /run/media/media_m/Anime/Airing/Boku\ no\ Kokoro\ no\ Yabai\ Yatsu/episode.txt)))-


# Define the list of anime series
declare -A anime_series=(
    ["jujutsu"]="jujutsu kaisen season 2"
    ["frieren"]="sousou no freiren"
    ["kage no"]="The Eminence in Shadow Season 2"
    ["spy"]="spy x family Season 2"
    ["tate no yuusha"]="tate no yuusha no nariagari 3"
    ["kusuriya"]="kusuriya no hitorigoto"
    ["yuzuki"]="Yuzuki-San Chi No Yon Kyoudai"
    ["ragna"]="ragna crimson"
)

file="$ANIME_DOWNLOAD_FOLDER/episode.txt"

# Process each anime series
for key in "${!anime_series[@]}"; do
    anime_name="${anime_series[$key]}"
    anime_num=$(cat "$file" | grep -iE "$key" | awk '{print $NF}')
    anime_num=$((10#$anime_num + 1))

    ./ani-cli -d -e "$anime_num" "$anime_name"
done

# Update anilist
bash $HOME/.config/animdl/anime_episode_update.sh
# Optional: python $HOME/.config/animdl/anilist_update.py
