{ config, lib, pkgs, ... }:

let
  anime_dl_env = pkgs.writeShellScriptBin "anime_dl_env" ''
                #!/usr/bin/env bash 
                while true 
        			do 
    					sleep 10m
        				kitty -e bash -c " 
        				hyprctl dispatch movetoworkspacesilent 10 
                nix-shell $HOME/.config/animdl/animdl.nix 
        				" 
        				sleep 6h  
        			done
  '';
  #  anime_downloader_daily = pkgs.writeShellScriptBin "anime_downloader_daily" '' 

  anime_list_update = pkgs.writeShellScriptBin "anime_list_update" '' 
#!/usr/bin/env bash 

ANIME_DIRECTORY="$ANIME_DOWNLOAD_FOLDER"  # Replace with your anime directory path

inotifywait -m -e delete --format '%w%f' "$ANIME_DIRECTORY" -r | while read -r FILE
do
    # Check if the deleted file is a video
    if [[ "$FILE" =~ \.(mp4|mkv|ts|avi)$ ]]; then
        # Parse the anime name and episode number from the deleted file's path
        ANIME_NAME=$(basename "$(dirname "$FILE")")
        EPISODE_NUMBER=$(echo "$FILE" | grep -oP '(?<=E)[0-9]+')
        $HOME/.config/animdl/anilist_update.py "$ANIME_NAME" "$EPISODE_NUMBER"  # Replace with your Python script path # Replace with your Python script path
    fi
done

'';
in

{
  home.packages = with pkgs; [
    anime_dl_env
    #anime_downloader_daily
    anime_list_update
  ];
}
