{ config, pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      cava
      mpc-cli
      mpd
      ncmpcpp
      musikcube
      termusic
    ];
  };
  programs = {
    ncmpcpp = {
      enable = true;
      mpdMusicDir = null;
    };
  };
  home.file = {
    ".config/ncmpcpp/config".text = ''
            mpd_music_dir = ~/Music 
      	  browser_sort = date_mod 
      	  playlist_sort = date_mod
    '';
  };

  services = {
    mpd = {
      enable = true;
      musicDirectory = "~/Music";
      extraConfig = ''
        audio_output {
                type            "pipewire"
                name            "PipeWire Sound Server"
        }
      '';
      network.listenAddress = "any"; # if you want to allow non-localhost connections
      # startWhenNeeded = true;
    };
  };
}
