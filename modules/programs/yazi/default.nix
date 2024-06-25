{ lib, user, pkgs, config, ... }:
{
  programs.yazi = {
    enable = true;
  };
  home = {
    packages = with pkgs; [ 
      file
      unar 
      ffmpegthumbnailer
      ueberzugpp
      autojump
      imagemagick
      #poppler
      #wkhtmltopdf
      chafa
      catdoc
      exiftool
      ctpv
      elinks
      jq
      poppler_utils
      mdcat
      zoxide
      xdragon 
    ];
  };
  home.file.".config/yazi".source = ./yazi; 
}
