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
animdl download "animepahe:masamune kun r" -d $ANIME_DOWNLOAD_FOLDER --index 1 -r $(($masamune_num + 1))
#horimiya
horimiya_num=$(cat "$file" | grep -iE "horimiya" | awk '{print $NF}')
animdl download "animepahe:horimiya piece" -d $ANIME_DOWNLOAD_FOLDER --index 1 -r $(($horimiya_num + 1))
# mushoku tensei
mushoku_num=$(cat "$file" | grep -iE "mushoku" | awk '{print $NF}')
animdl download "animepahe:mushoku tensei ii isekai ittara" -d $ANIME_DOWNLOAD_FOLDER --index 1 -r $(($mushoku_num + 1))
# bleach
bleach_num=$(cat "$file" | grep -iE "bleach" | awk '{print $NF}')
animdl download "gogoanime:bleach sennen kessen hen ketsubetsu" -d $ANIME_DOWNLOAD_FOLDER --index 1 -r $(($bleach_num + 1))
#jujutsu kaisen
jujutsu_num=$(cat "$file" | grep -iE "jujutsu" | awk '{print $NF}')
animdl download "animepahe:jujutsu kaisen second" -d $ANIME_DOWNLOAD_FOLDER --index 1 -r $(($jujutsu_num + 1))

#zom 100
zom_100_num=$(cat "$file" | grep -iE "zom 100" | awk '{print $NF}')
animdl download "animepahe:zom 100" -d $ANIME_DOWNLOAD_FOLDER --index 1 -r $(($zom_100_num + 1))

link_click_2=$(cat "$file" | grep -iE "link click" | awk '{print $NF}')
animdl download "animepahe:link click 2" -d $ANIME_DOWNLOAD_FOLDER --index 1 -r $(($link_click_2 + 1))


#update anilist
bash $HOME/.config/animdl/anime_episode_update.sh && exit
#python $HOME/.config/animdl/anilist_update.py
