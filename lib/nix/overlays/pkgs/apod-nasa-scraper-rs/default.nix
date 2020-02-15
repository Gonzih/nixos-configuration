{ stdenv, rustPlatform, fetchFromGitHub }:

rustPlatform.buildRustPackage rec {
  name = "apod-nasa-scraper-rs-${version}";
  version = "544c75b8dcb6b8264e9c3d4563b8d7aa315f39a0";

  src = fetchFromGitHub {
    owner = "Gonzih";
    repo = "apod-nasa-scraper-rs";
    rev = "${version}";
    sha256 = "00p155bkvmwyyl5aqd6b97m63k4idjz4qy8nyqpyy4fpjws8mlxc";
  };

  cargoSha256 = "0q68qyl2h6i0qsz82z840myxlnjay8p1w5z7hfyr8fqp7wgwa9cx";

  meta = with stdenv.lib; {
    description = "Nasa picture of the day scraper";
    homepage = https://github.com/Gonzih/apod-nasa-scraper-rs;
    license = licenses.unlicense;
    maintainers = [ maintainers.Gonzih ];
    platforms = platforms.all;
  };
}
