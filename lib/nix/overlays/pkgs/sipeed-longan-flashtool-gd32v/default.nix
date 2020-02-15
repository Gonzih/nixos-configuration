{ stdenv
, fetchurl
, glibc
, zlib
, libusb
, autoPatchelfHook
}:

stdenv.mkDerivation rec {
  pname = "sipeed-longan-flashtool-gd32v";
  version = "0.1.0";

  src = fetchurl {
    url = "http://dl.sipeed.com/LONGAN/platformio/dl-packages/tool-gd32vflash-v${version}-linux.tar.gz";
    sha256 = "0kxlayz7pf3md2580chclqcn908cyg2ljksfazz8mk3gzx0yk0v2";
  };

  nativeBuildInputs = [ autoPatchelfHook ];

  sourceRoot = ".";

  buildInputs = [ libusb ];

  installPhase = ''
    mkdir -p $out/usr
    mkdir -p $out/bin
    cp dfu-prefix $out/bin
    cp dfu-suffix $out/bin
    cp dfu-util $out/bin
    cp stm32flash $out/bin
  '';

  meta = with stdenv.lib; {
    homepage = https://www.seeedstudio.com/Sipeed-Longan-Nano-RISC-V-GD32VF103CBT6-Development-Board-p-4205.html;
    description = "GNU flashing tool for RISCV dev board from sipeed";
    platforms = platforms.linux;
    maintainers = with maintainers; [ Gonzih ];
  };
}
