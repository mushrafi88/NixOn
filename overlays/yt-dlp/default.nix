self: super:
{
  yt-dlp = super.yt-dlp.overrideAttrs (old: rec {
    src = super.fetchgit {
      url    = "https://github.com/yt-dlp/yt-dlp.git";
      rev    = "741fd80";
      sha256 = "sha256-M5GHJyPqyAmoe5v1RSckwdpEuGlgLY0kXCcynlE7e08=";
    };
  });
}

