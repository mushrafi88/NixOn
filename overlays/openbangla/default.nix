self: super:
{
  openbangla-keyboard = super.mpv.overrideAttrs (old: {
    src = super.fetchFromGitHub {
      owner = "asifakonjee";
      repo = "openbangla-keyboard";
      rev = "73012424cfb4db310250836e63cd87ac84106c1b";
hash = "sha256-3moWzvuCD952sJGQct97k3Ls05S1ZavWhtH4LEdjUTI=";
fetchSubmodules = true;
};
  });
}
