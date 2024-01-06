{ config, lib, pkgs, ... }:

let
  yt_music = pkgs.writeShellScriptBin "yt_music" ''
          #!/usr/bin/env bash 
          while true  
        	  do   
    			  sleep 5m
        		  dunstify "Downloading Songs from Youtube" -i "~/.config/dunst/icon/normal.jpg" 
        		  kitty -e bash -c "
        		    hyprctl dispatch movetoworkspacesilent 10 
                dl_music_yt 
        			  exit
        		  "
                  sleep 8h
              done
  '';

  dl_music_yt = pkgs.writeShellScriptBin "dl_music_yt" '' 
#!/usr/bin/env bash 

mkdir -p $MUSIC_DOWNLOAD_FOLDER/{youtube/trimming,Anime/trimming} 

yt-dlp -f 'ba' -x --audio-format mp3 --embed-thumbnail --embed-metadata --download-archive  "$MUSIC_DOWNLOAD_FOLDER/youtube/trimming/dl.txt" -o "$MUSIC_DOWNLOAD_FOLDER/youtube/%(title)s.%(ext)s" 'https://www.youtube.com/playlist?list=PLuLW3E9NVjak789Pzx4vb5_7xxfLMTNE7'



yt-dlp -f 'ba' -x --audio-format mp3 --playlist-end 20 --embed-thumbnail --embed-metadata --download-archive "$MUSIC_DOWNLOAD_FOLDER/Anime/trimming/dl.txt"  -o "$MUSIC_DOWNLOAD_FOLDER/Anime/%(title)s.%(ext)s" 'https://www.youtube.com/playlist?list=PLuLW3E9NVjakix7eyfBRb-tTUy3kIjOsH'
'';
in

{
  home.packages = with pkgs; [
    yt_music
    dl_music_yt
  ];
}
