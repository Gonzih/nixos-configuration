{ stdenv, buildGoPackage, fetchFromGitHub }:

buildGoPackage rec {
  name = "gorun-${version}";
  version = "master-85cd5f5e084af0863ed0c3f18c00e64526d1b899";
  goPackagePath = "github.com/erning/gorun";

  src = fetchFromGitHub {
    owner = "erning";
    repo = "gorun";
    rev = "85cd5f5e084af0863ed0c3f18c00e64526d1b899";
    sha256 = "1hdqimfzpynnpqc7p8m8hkcv9dlfbd8kl22979i6626nq57dvln8";
  };

  meta = with stdenv.lib; {
    description = "gorun is a tool enabling one to put a \"bang line\" in the source code of a Go program to run it";
    homepage = https://github.com/erning/gorun;
    license = licenses.mit;
    maintainers = with maintainers; [ Gonzih ];
    platforms = platforms.linux ++ platforms.darwin;
  };
}
