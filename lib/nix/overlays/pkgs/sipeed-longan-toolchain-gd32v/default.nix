{ stdenv
, fetchurl
, glibc
, zlib
# , libgcc
# , gcc
# , libstdcxx5
# , ncurses
# , saw-tools
, autoPatchelfHook
}:

stdenv.mkDerivation rec {
  pname = "sipeed-longan-toolchain-gd32v";
  version = "9.2.0";

  src = fetchurl {
    url = "dl.sipeed.com/LONGAN/platformio/dl-packages/toolchain-gd32v-v${version}-linux.tar.gz";
    sha256 = "0794gfs5vfjj2xc85nw88xa0f20iwdakph242b7h7wy6cpy4y4y2";
  };

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  sourceRoot = ".";

  buildInputs = [
    glibc
    zlib
    # libgcc
    # gcc
    # libstdcxx5
    # saw-tools
    # ncurses
  ];

  # without gdb support for now
  # also without another dir
    # cp -r lib $out/usr/lib
    # cp -r include $out/usr/include
    # cp -r libexec $out/usr/libexec
    # cp -r riscv-nuclei-elf $out/usr/riscv-nuclei-elf
    # cp -r share $out/usr/share
  installPhase = ''
    mkdir -p $out/usr
    cp -r bin $out/bin
    rm -f $out/bin/riscv-nuclei-elf-gdb
  '';

  meta = with stdenv.lib; {
    homepage = https://www.seeedstudio.com/Sipeed-Longan-Nano-RISC-V-GD32VF103CBT6-Development-Board-p-4205.html;
    description = "GNU Toolchain for RISCV dev board from sipeed";
    platforms = platforms.linux;
    maintainers = with maintainers; [ Gonzih ];
  };
}
