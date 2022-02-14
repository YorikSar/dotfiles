#!/usr/bin/env bash
set -ueo pipefail
d="$(dirname "$0")"
binCache="$(md5 -q /usr/bin/git)"
find {,/usr}/{,s}bin -type f | xargs md5 -r | grep "$binCache" | cut -f 4 -d / | sort -u > "$d/xcrun-subst.lst"
