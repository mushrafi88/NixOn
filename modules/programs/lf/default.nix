{ pkgs, config, ... }:
{
  home = {
    packages = with pkgs; [
      lf
      file
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
    ];
  };
  home.file.".config/lf".source = ./config;
}
