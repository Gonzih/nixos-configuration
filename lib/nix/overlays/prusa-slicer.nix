self: super:
let
  nloptVersion = if super.lib.hasAttr "version" super.nlopt
                 then super.lib.getAttr "version" super.nlopt
                 else "2.4";
in
{
  prusa-slicer = super.prusa-slicer.overrideAttrs ( old: rec {
    version = "2.2.0-alpha2";
    src = super.fetchFromGitHub {
      owner = "prusa3d";
      repo = "PrusaSlicer";
      sha256 = "18nbgpv1j9dp43shzy83qffgs78dlyx2zl17bpzghx65p9z54qs9";
      rev = "version_${version}";
    };
    buildInputs = old.buildInputs ++ [ super.libudev super.cereal ];
    prePatch = ''
    # In nix ioctls.h isn't available from the standard kernel-headers package
    # like in other distributions. The copy in glibc seems to be identical to the
    # one in the kernel though, so we use that one instead.
      sed -i 's|"/usr/include/asm-generic/ioctls.h"|<asm-generic/ioctls.h>|g' src/libslic3r/GCodeSender.cpp
    '' + super.lib.optionalString (super.lib.versionOlder "2.5" nloptVersion) ''
    # Since version 2.5.0 of nlopt we need to link to libnlopt, as libnlopt_cxx
    # now seems to be integrated into the main lib.
      sed -i 's|nlopt_cxx|nlopt|g' cmake/modules/FindNLopt.cmake
    '';
  });
}
