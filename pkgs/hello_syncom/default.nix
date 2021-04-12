{ stdenv
, lib
, zlib
#, fetchurl
, autoPatchelfHook
}:

stdenv.mkDerivation rec {
  name = "hello_syncom";
  version = "1.0.0";

  src = ./hello_syncom.tar.gz;
#  src = fetchurl {
#    url = "";
#    sha256 = "0yyyyz4hhmkk4wc8rqhnz13nqc61mp0jqhc5zzxr9qip85cpispx";
#  };

  sourceRoot = ".";
#  dontPatch = true;
  dontConfigure = true;
  dontBuild = true;
  dontCheck = true;
#  dontFixup = true;
#  dontStrip = true;
  dontMoveSbin = true;
#  dontPatchELF = false;
  

  nativeBuildInputs = [
    zlib
    autoPatchelfHook
  ];

  buildInputs = [
  ];

#  unpackPhase = "true";

  installPhase = ''
    echo "hello_syncom: $out"
    mkdir -p $out
    cp -r ./hello_syncom/* $out/
  '';

  meta = with lib; {
    description = "hello syncom";
    platforms = platforms.linux;
    maintainers = with maintainers; [ syncom ];
  };
}
