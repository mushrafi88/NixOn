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
masamune_num=$(cat "$file" | grep -iE "masamune" | awk '{print $NF}')
echo "Original masamune_num: $masamune_num"
masamune_num=$((10#$masamune_num + 1))
echo "Incremented masamune_num: $masamune_num"
animdl download "animepahe:masamune kun r" -d $ANIME_DOWNLOAD_FOLDER --index 1 -r "$masamune_num"
#horimiya
horimiya_num=$(cat "$file" | grep -iE "horimiya" | awk '{print $NF}')
horimiya_num=$((10#$horimiya_num + 1))
animdl download "animepahe:horimiya piece" -d $ANIME_DOWNLOAD_FOLDER --index 1 -r "$horimiya_num"
# mushoku tensei
mushoku_num=$(cat "$file" | grep -iE "mushoku" | awk '{print $NF}')
mushoku_num=$((10#$mushoku_num + 1))
animdl download "animepahe:mushoku tensei ii isekai ittara" -d $ANIME_DOWNLOAD_FOLDER --index 1 -r "$mushoku_num"
# bleach
bleach_num=$(cat "$file" | grep -iE "bleach" | awk '{print $NF}')
bleach_num=$((10#$bleach_num + 1))
animdl download "gogoanime:bleach sennen kessen hen ketsubetsu" -d $ANIME_DOWNLOAD_FOLDER --index 1 -r "$bleach_num"
#jujutsu kaisen
jujutsu_num=$(cat "$file" | grep -iE "jujutsu" | awk '{print $NF}')
jujutsu_num=$((10#$jujutsu_num + 1))
animdl download "animepahe:jujutsu kaisen second" -d $ANIME_DOWNLOAD_FOLDER --index 1 -r "$jujutsu_num"

#zom 100
zom_100_num=$(cat "$file" | grep -iE "zom 100" | awk '{print $NF}')
zom_100_num=$((10#$zom_100_num + 1))
animdl download "animepahe:zom 100" -d $ANIME_DOWNLOAD_FOLDER --index 1 -r "$zom_100_num"

link_click_2=$(cat "$file" | grep -iE "link click" | awk '{print $NF}')
link_click_2=$((10#$link_click_2 + 1))
animdl download "animepahe:link click 2" -d $ANIME_DOWNLOAD_FOLDER --index 1 -r "$link_click_2"


#update anilist
bash $HOME/.config/animdl/anime_episode_update.sh && exit
#python $HOME/.config/animdl/anilist_update.py
