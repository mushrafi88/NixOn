self: super:
{
  lf = super.lf.overrideAttrs (old: {
    src = super.fetchFromGitHub {
      owner = "horriblename";
      repo = "lf";
      rev = "1bb0b43";
      hash = "sha256-hlhmnkPm1x7uJMwUM/B02rXLffsXFbkxXYITKD3BERY=";
    };
  });
}
