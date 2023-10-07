#!/usr/bin/env bash

#youtube dl
#yt-dlp -f 'bestvideo[height=1080]+bestaudio/best' --write-sub --embed-subs --yes-playlist -o "/home/venerable_white/Videos/Anime/Airing/by_the_grace_of_god/%(title)s.%(ext)s" --download-archive dl.txt 'https://www.youtube.com/playlist?list=PLxSscENEp7JgZhNUrkpwoksoSLEmTqB6U'

#anime downlader-vnki
#anime dl -c 18 -p animerush -e $((1+$(cat /run/media_m/Anime/Airing/isekai_ojisan/episode.txt))): --download-dir /run/media_m/Anime/Airing/isekai_ojisan 'Isekai Ojisan'

# sources for animdl - animeout, animepahe, kawaiifu, marin, zoro, gogoanime, haho
#
#the dangers in my heart
#animdl download "animepahe:The dangers in my heart" -d /run/media/media_m/Anime/Airing/ --index 1 -r $((1+$(cat /run/media/media_m/Anime/Airing/Boku\ no\ Kokoro\ no\ Yabai\ Yatsu/episode.txt)))-
file="$ANIME_DOWNLOAD_FOLDER/episode.txt"
# masamune kun


#jujutsu kaisen
jujutsu_num=$(cat "$file" | grep -iE "jujutsu" | awk '{print $NF}')
jujutsu_num=$((10#$jujutsu_num + 1))
animdl download "animepahe:jujutsu kaisen second" -d $ANIME_DOWNLOAD_FOLDER --index 1 -r "$jujutsu_num"

#zom 100
zom_100_num=$(cat "$file" | grep -iE "zom 100" | awk '{print $NF}')
zom_100_num=$((10#$zom_100_num + 1))
animdl download "animepahe:zom 100" -d $ANIME_DOWNLOAD_FOLDER --index 1 -r "$zom_100_num"

freiren_num=$(cat "$file" | grep -iE "frieren" | awk '{print $NF}')
freiren_num=$((10#$freiren_num + 1))
animdl download "animepahe:sousou no freiren" -d $ANIME_DOWNLOAD_FOLDER --index 1 -r "$freiren_num"

eminence_num=$(cat "$file" | grep -iE "kage no" | awk '{print $NF}')
eminence_num=$((10#$eminence_num + 1))
animdl download "animepahe: The Eminence in Shadow Season 2" -d $ANIME_DOWNLOAD_FOLDER --index 1 -r "$eminence_num"


#update anilist
bash $HOME/.config/animdl/anime_episode_update.sh && exit
#python $HOME/.config/animdl/anilist_update.py
