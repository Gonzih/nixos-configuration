{ stdenv, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "feeds2imap";
  version = "39c22ec6a5aa0cfea864a8dafe40f065f11ad511";

  # https://github.com/hairyhenderson/gomplate
  src = fetchFromGitHub {
    owner = "Gonzih";
    repo = "feeds2imap-go";
    rev = version;
    sha256 = "1nm16il5azaq4dfw4c5ws1s6nkl85l9xpsx0yz72ss6429rnrhbr";
  };

  modSha256 = "1v2wxym2m7zjqmr2fhdd63nvwbmh3cxs1rjn0jd96vdyjcdnx1ms";

  meta = with stdenv.lib; {
    description = "Feeds2imap";
    homepage = https://github.com/Gonzih/feeds2imap-go;
    license = licenses.mit;
    maintainers = with maintainers; [ Gonzih ];
    platforms = platforms.linux ++ platforms.darwin;
  };
}
