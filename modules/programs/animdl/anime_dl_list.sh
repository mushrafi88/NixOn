#!/usr/bin/env bash

#youtube dl
#yt-dlp -f 'bestvideo[height=1080]+bestaudio/best' --write-sub --embed-subs --yes-playlist -o "/home/venerable_white/Videos/Anime/Airing/by_the_grace_of_god/%(title)s.%(ext)s" --download-archive dl.txt 'https://www.youtube.com/playlist?list=PLxSscENEp7JgZhNUrkpwoksoSLEmTqB6U'

#anime downlader-vnki
#anime dl -c 18 -p animerush -e $((1+$(cat /run/media_m/Anime/Airing/isekai_ojisan/episode.txt))): --download-dir /run/media_m/Anime/Airing/isekai_ojisan 'Isekai Ojisan'

# sources for animdl - animeout, animepahe, kawaiifu, marin, zoro, gogoanime, haho



#vinland_saga
#anime dl -c 1 -p vidstream -e $((1+$(cat /run/media_m/Anime/Airing/vinland_saga/episode.txt))): --download-dir /run/media_m/Anime/Airing/vinland_saga  'https://www.animerush.tv/anime/Vinland-Saga-Season-2/'

#oshi no ko
animdl download "animepahe:oshi no ko" -d /run/media/media_m/Anime/Airing/ --index 1 -r $((1+$(cat /run/media/media_m/Anime/Airing/-\ Oshi\ no\ Ko\ -/episode.txt)))-

#isekai_bully
animdl download "animepahe:i got a cheat skill in the other world" -d /run/media/media_m/Anime/Airing/ --index 1 -r $((1+$(cat /run/media/media_m/Anime/Airing/Isekai\ de\ Cheat\ Skill\ wo\ Te\ ni\ Shita\ Ore\ wa,\ Genjitsu\ Sekai\ wo\ mo\ Musou\ Suru\ -\ \ Level\ Up\ wa\ Jinsei\ wo\ Kaeta/episode.txt)))-

# jigokuraku
animdl download "animepahe:jigokuraku" -d /run/media/media_m/Anime/Airing/ --index 1 -r $((1+$(cat /run/media/media_m/Anime/Airing/Jigokuraku/episode.txt)))-

#my married life
animdl download "animepahe:otonari ni ginga" -d /run/media/media_m/Anime/Airing/ --index 1 -r $((1+$(cat /run/media/media_m/Anime/Airing/Otonari\ ni\ Ginga/episode.txt)))-

# tonikaku kawaii
animdl download "animepahe:tonikaku kawai 2" -d /run/media/media_m/Anime/Airing/ --index 1 -r $((1+$(cat /run/media/media_m/Anime/Airing/Tonikaku\ Kawaii\ 2nd\ Season/episode.txt)))-

#konosuba bakuen
animdl download "animepahe:konosuba bakuen" -d /run/media/media_m/Anime/Airing/ --index 1 -r $((1+$(cat /run/media/media_m/Anime/Airing/Kono\ Subarashii\ Sekai\ ni\ Bakuen\ wo\!/episode.txt)))-

#kimetsu no yaiba
animdl download "animepahe:kimetsu no yaiba swordsmith" -d /run/media/media_m/Anime/Airing/ --index 1 -r $((1+$(cat /run/media/media_m/Anime/Airing/Kimetsu\ no\ Yaiba\ -\ \ Katanakaji\ no\ Sato-hen/episode.txt)))-

#yamada-
animdl download "animepahe:yamada kun lv999" -d /run/media_m/Anime/Airing/ --index 1 -r $((1+$(cat /run/media_m/Anime/Airing/Yamada-kun\ to\ Lv999\ no\ Koi\ wo\ Suru/episode.txt)))-

#insomnia  mnrun/
animdl download "animepahe:kimi wa insomniac" -d /run/media/media_m/Anime/Airing/ --index 1 -r $((1+$(cat /run/media/media_m/Anime/Airing/Kimi\ wa\ Houkago\ Insomnia/episode.txt)))-

#heavenly delusion
animdl download "animepahe:tengoku daimakyou" -d /run/media/media_m/Anime/Airing/ --index 1 -r $((1+$(cat /run/media/media_m/Anime/Airing/Tengoku\ Daimakyou/episode.txt)))-

#yuusha ga shinda
animdl download "animepahe:yuusha ga shinda" -d /run/media/media_m/Anime/Airing/ --index 1 -r $((1+$(cat /run/media/media_m/Anime/Airing/Yuusha\ ga\ Shinda\!/episode.txt)))-

#blue orchestra  X
animdl download "gogoanime:The blue orchestra" -d /run/media/media_m/Anime/Airing/ --index 1 -r $((1+$(cat /run/media_m/Anime/Airing/Ao\ no\ Orchestra/episode.txt)))-

#the dangers in my heart
animdl download "animepahe:The dangers in my heart" -d /run/media/media_m/Anime/Airing/ --index 1 -r $((1+$(cat /run/media/media_m/Anime/Airing/Boku\ no\ Kokoro\ no\ Yabai\ Yatsu/episode.txt)))-

#home hero
yt-dlp -f 'bestvideo[height=1080]+bestaudio/best' --write-sub --embed-subs --yes-playlist -o "/home/venerable_white/Videos/Anime/Airing/My_Home_Hero/%(title)s.%(ext)s" --download-archive dl.txt 'https://www.youtube.com/playlist?list=PLxSscENEp7Jgrs9B0sIbeAydZ-IaNhcvh'

#update anilist
python $HOME/.config/animdl/anilist_update.py
