self: super:
{
  lf = super.lf.overrideAttrs (old: {
    src = super.fetchFromGitHub {
      owner = "horriblename";
      repo = "lf";
      rev = "741dd48";
      hash = "sha256-hlhmnkPm1x7uJMwUM/B02rXLffsXFbkxXYITKD3BERY=";
    };
  });
}
