#!/usr/bin/env bash
set -ueo pipefail
d="$(dirname "$0")"
otool="$(nix build --no-link --print-out-paths nixpkgs\#darwin.binutils-unwrapped^out)/bin/otool"

# Binaries that are shims for xcode-select have only following deps:
# $ otool -L /usr/bin/git
# /usr/bin/git (architecture x86_64):
#         /usr/lib/libxcselect.dylib (compatibility version 1.0.0, current version 1.0.0)
#         /usr/lib/libSystem.B.dylib (compatibility version 1.0.0, current version 1336.80.1)
# /usr/bin/git (architecture arm64e):
#         /usr/lib/libxcselect.dylib (compatibility version 1.0.0, current version 1.0.0)
#         /usr/lib/libSystem.B.dylib (compatibility version 1.0.0, current version 1336.80.1)
# Filter them out based on the presence of libxcselect.dylib and number of lines

find {,/usr}/{,s}bin -type f -exec sh -c 'l="$('"$otool"' -L {})"; [ "$(echo "$l" | wc -l)" -eq 6 ] && ( echo $l | grep -q /usr/lib/libxcselect.dylib )' \; -print | cut -f 4 -d / | sort -u > "$d/xcrun-subst.lst"
