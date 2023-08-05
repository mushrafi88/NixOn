{ pkgs, config, ... }:
{
  home = {
    packages = with pkgs; [
      file
      lf
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
    ];
  };
  home.file.".config/lf".source = ./config;
}
