self: super:
{
  mpv = super.mpv.overrideAttrs (old: {
    src = super.fetchFromGitHub {
      owner = "mpv-player";
      repo = "mpv";
      rev = "f4210f8";
      hash = "sha256-hlhmnkPm1x7uJMwUM/B02rXLffsXFbkxXYITKD3BERY=";
    };
  });
}
