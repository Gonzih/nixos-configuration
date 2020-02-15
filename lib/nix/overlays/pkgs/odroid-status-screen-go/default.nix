{ stdenv, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "odroid-status-screen-go";
  version = "5d9c940ae83f319dde40ab64ec9e898c3cb76576";

  src = fetchFromGitHub {
    owner = "Gonzih";
    repo = "odroid-status-screen-go";
    rev = version;
    sha256 = "0q4n777ccq8c5r36zn673hbhfad2j9wqsqhii53z6nw1ky7vy7bi";
  };

  modSha256 = "10r0dkxnxkm73bs7gc1bx3l8w2wl00dj8iwmi8pki1vhib3yq1ky";

  subPackages = [ "." ];

  meta = with stdenv.lib; {
    description = "Odroid status screen.";
    homepage = https://github.com/Gonzih/odroid-status-screen-go;
    license = licenses.mit;
    maintainers = with maintainers; [ Gonzih ];
  };
}
