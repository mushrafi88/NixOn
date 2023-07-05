{ lib, pkgs, user, ... }:
{
  home.file.".config/animdl/animdl.nix".source = ./animdl.nix;
  home.file.".config/animdl/anime_dl_list.sh".source = ./anime_dl_list.sh;
  home.file.".config/animdl/anilist_update.py".source = ./anilist_update.py;
  home.file.".config/animdl/anime_update.py".source = ./anime_update.py;

}
