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
    ];
  };
  home.file.".config/lf".source = ./config;
}
