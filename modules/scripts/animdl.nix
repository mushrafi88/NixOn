{ config, lib, pkgs, ... }:

let
  anime_dl_env = pkgs.writeShellScriptBin "anime_dl_env" ''
            #!/usr/bin/env bash 
            while true 
    			do 
    				kitty -e bash -c " 
    				hyprctl dispatch movetoworkspacesilent D 
                    nix-shell $HOME/.config/animdl/animdl.nix 
    				" 
    				sleep 6h  
    			done
  '';
  #  anime_downloader_daily = pkgs.writeShellScriptBin "anime_downloader_daily" '' 

  anime_downloader_folder_watcher = pkgs.writeShellScriptBin "anime_downloader_folder_watcher" '' 
#!/usr/bin/env bash 

ANIME_DIRECTORY="$ANIME_DOWNLOAD_FOLDER"  # Replace with your anime directory path
EPISODE_FILE="$ANIME_DOWNLOAD_FOLDER/w_episode.txt"  # Replace with your episode.txt file path

inotifywait -m -e delete --format '%w%f' "$ANIME_DIRECTORY" -r | while read -r FILE
do
    # Check if the deleted file is a video
    if [[ "$FILE" =~ \.(mp4|mkv|ts|avi)$ ]]; then
        # Parse the anime name and episode number from the deleted file's path
        ANIME_NAME=$(basename "$(dirname "$FILE")")
        EPISODE_NUMBER=$(echo "$FILE" | grep -oP '(?<=E)[0-9]+')

        echo "$ANIME_NAME $EPISODE_NUMBER" >> "$EPISODE_FILE"

        python $HOME/.config/animdl/anilist_update.py  # Replace with your Python script path
    fi
done

'';
in

{
  home.packages = with pkgs; [
    anime_dl_env
    #anime_downloader_daily
    anime_downloader_folder_watcher
  ];
}
