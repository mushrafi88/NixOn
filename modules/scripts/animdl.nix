{ config, lib, pkgs, ... }:

let
  anime_dl_env = pkgs.writeShellScriptBin "anime_dl_env" ''
        #!/usr/bin/env bash
        kitty -e bash -c "
    	  hyprctl dispatch movetoworkspacesilent D 
          nix-shell $HOME/.config/animdl/animdl.nix 
        "
  '';
  #  anime_downloader_daily = pkgs.writeShellScriptBin "anime_downloader_daily" '' 

  anime_downloader_folder_watcher = pkgs.writeShellScriptBin "anime_downloader_folder_watcher" '' 
#!/usr/bin/env bash 


inotifywait -m -r -e delete --format "%w%f" "/run/media/media_m/Anime/Airing" | while read file
do
    # Run your script here
    python $HOME/.config/animdl/anilist_update.py 
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
