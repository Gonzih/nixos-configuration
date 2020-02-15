{ stdenv, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "gomplate";
  version = "0.7.13";

  # https://github.com/hairyhenderson/gomplate
  src = fetchFromGitHub {
    owner = "derailed";
    repo = "hairyhenderson";
    rev = version;
    sha256 = "0wsj6wc2qi5708cg47l2qblq1cg8000000000000000000000008";
  };

  modSha256 = "1ia9wx6yd9mdr981lcw58xv39iq111111111111111111111cjq8";

  meta = with stdenv.lib; {
    description = "Gomplate crap";
    homepage = https://github.com/derailed/k9s;
    license = licenses.asl20;
    maintainers = with maintainers; [ Gonzih ];
    platforms = platforms.linux ++ platforms.darwin;
  };
}
