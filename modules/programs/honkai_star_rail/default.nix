let
  aagl-gtk-on-nix = import (builtins.fetchTarball {
    url = "https://github.com/ezKEa/aagl-gtk-on-nix/archive/main.tar.gz";
    sha256 = "1204p1hysxncsfh3p7dkx4xxv30nqf4llck1dkxf1f72qsnpm62j";
    });
in
{
  home.packages = [ aagl-gtk-on-nix.the-honkers-railway-launcher ];
}
