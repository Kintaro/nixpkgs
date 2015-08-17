{ stdenv, fetchurl, libXi, libXrandr, libXxf86vm, mesa, x11, cmake }:

let version = "3.0.0";
in stdenv.mkDerivation {
  name = "freeglut-${version}";

  src = fetchurl {
    url = "mirror://sourceforge/freeglut/freeglut-${version}.tar.gz";
    sha256 = "18knkyczzwbmyg8hr4zh8a1i5ga01np2jzd1rwmsh7mh2n2vwhra";
  };

  buildInputs = [ libXi libXrandr libXxf86vm mesa x11 cmake ];

  postPatch = lib.optionalString stdenv.isDarwin ''
    substituteInPlace Makefile.am --replace \
      "SUBDIRS = src include progs doc" \
      "SUBDIRS = src include doc"
  '';

  configureFlags = [ "--enable-warnings" ];
}
