let
  common = import ../common;
in
[
  ./imgview
  ./launcher
  ./mako
  ./mpv
  ./kooha
] ++ common
