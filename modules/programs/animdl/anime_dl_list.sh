#!/usr/bin/env bash

#youtube dl
#yt-q best -dlp -f 'bestvideo[height=1080]+bestaudio/best' --write-sub --embed-subs --yes-playlist -o "/home/venerable_white/Videos/Anime/Airing/by_the_grace_of_god/%(title)s.%(ext)s" --download-archive dl.txt 'https://www.youtube.com/playlist?list=PLxSscENEp7JgZhNUrkpwoksoSLEmTqB6U'

#anime downlader-vnki
#anime dl -c 18 -p animerush -e $((1+$(cat /run/media_m/Anime/Airing/isekai_ojisan/episode.txt))): --q best -download-dir /run/media_m/Anime/Airing/isekai_ojisan 'Isekai Ojisan'

# sources for animdl - animeout, animepahe, kawaiifu, marin, zoro, gogoanime, haho
#
#the dangers in my heart
#animdl download "animepahe:The dangers in my heart" -q best -d /run/media/media_m/Anime/Airing/ --index 1 -r $((1+$(cat /run/media/media_m/Anime/Airing/Boku\ no\ Kokoro\ no\ Yabai\ Yatsu/episode.txt)))-
file="$ANIME_DOWNLOAD_FOLDER/episode.txt"
# masamune kun

# Function to move downloaded episode to specific folder
move_to_folder() {
    local anime_name="$1"
    local episode_num="$2"
    mkdir -p "$ANIME_DOWNLOAD_FOLDER/$anime_name"
    mv "Episode_${episode_num}_*" "$ANIME_DOWNLOAD_FOLDER/$anime_name/"
}

#jujutsu kaisen
jujutsu_num=$(cat "$file" | grep -iE "jujutsu" | awk '{print $NF}')
jujutsu_num=$((10#$jujutsu_num + 1))
ani-cli -d -e "$jujutsu_num" "jujutsu kaisen season 2"
move_to_folder "jujutsu kaisen season 2" "$jujutsu_num"

#sousou no freiren
freiren_num=$(cat "$file" | grep -iE "frieren" | awk '{print $NF}')
freiren_num=$((10#$freiren_num + 1))
ani-cli -d -e "$freiren_num" "sousou no freiren"
move_to_folder "sousou no freiren" "$freiren_num"

#The Eminence in Shadow Season 2
eminence_num=$(cat "$file" | grep -iE "kage no" | awk '{print $NF}')
eminence_num=$((10#$eminence_num + 1))
ani-cli -d -e "$eminence_num" "The Eminence in Shadow Season 2"
move_to_folder "The Eminence in Shadow Season 2" "$eminence_num"

#spy x family Season 2
spy_num=$(cat "$file" | grep -iE "spy" | awk '{print $NF}')
spy_num=$((10#$spy_num + 1))
ani-cli -d -e "$spy_num" "spy x family Season 2"
move_to_folder "spy x family Season 2" "$spy_num"

#tate no yuusha no nariagari 3
yuusha_num=$(cat "$file" | grep -iE "tate no yuusha" | awk '{print $NF}')
yuusha_num=$((10#$yuusha_num + 1))
ani-cli -d -e "$yuusha_num" "tate no yuusha no nariagari 3"
move_to_folder "tate no yuusha no nariagari 3" "$yuusha_num"

#kusuriya no hitorigoto
kusuriya_num=$(cat "$file" | grep -iE "kusuriya" | awk '{print $NF}')
kusuriya_num=$((10#$kusuriya_num + 1))
ani-cli -d -e "$kusuriya_num" "kusuriya no hitorigoto"
move_to_folder "kusuriya no hitorigoto" "$kusuriya_num"

#Yuzuki-San Chi No Yon Kyoudai
yuzuki_num=$(cat "$file" | grep -iE "yuzuki" | awk '{print $NF}')
yuzuki_num=$((10#$yuzuki_num + 1))
ani-cli -d -e "$yuzuki_num" "Yuzuki-San Chi No Yon Kyoudai"
move_to_folder "Yuzuki-San Chi No Yon Kyoudai" "$yuzuki_num"

#ragna crimson
ragna_num=$(cat "$file" | grep -iE "ragna" | awk '{print $NF}')
ragna_num=$((10#$ragna_num + 1))
ani-cli -d -e "$ragna_num" "ragna crimson"
move_to_folder "ragna crimson" "$ragna_num"

#update anilist
bash $HOME/.config/animdl/anime_episode_update.sh && exit
#python $HOME/.config/animdl/anilist_update.py
