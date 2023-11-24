self: super:
{
  mpv = super.mpv.overrideAttrs (old: {
    src = super.fetchFromGitHub {
      owner = "mpv-player";
      repo = "mpv";
      rev = "6e161ff";
      hash = "sha256-hlhmnkPm1x7uJMwUM/B02rXLffsXFbkxXYITKD3BERY=";
    };
  });
}
