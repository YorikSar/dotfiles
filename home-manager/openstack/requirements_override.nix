{ pkgs, python }:

self: super: {
#  "cffi" = super."cffi".overrideDerivation(old: {
#    buildInputs = old.buildInputs ++ [ pkgs.libffi ];
#  });
#  "cryptography" = super."cryptography".overrideDerivation(old: {
#    buildInputs = old.buildInputs ++ [ pkgs.openssl ];
#  });
}
