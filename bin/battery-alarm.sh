#!/bin/bash
BAT_NUM="$1"
if [ -z "$BAT_NUM" ]; then
    echo "Please specify battery number" 1>&2
    exit 1
fi
bat_info_dir="/proc/acpi/battery/BAT$BAT_NUM"
CRIT_LEVEL="${2:-10}"

get_val() {
    awk 'BEGIN { FS=":"; } '"/$1:/ "'{ split($2, a, " "); print a[1]; }' $2
}

battery_low() {
    cur_charge="$(get_val "remaining capacity" "$bat_info_dir/state")"
    max_charge="$(get_val "design capacity" "$bat_info_dir/info")"
    charging="$(get_val "charging state" "$bat_info_dir/state")"
    perc_charge=$(( 100 * cur_charge / max_charge ))
    if [ $perc_charge -gt $CRIT_LEVEL -o "$charging" = "charging" ]; then
        return 1
    fi
}

run_osd_cat() {
    osd_cat -l 1 -p middle -A center -d 3 -f '-*-fixed-bold-*-*-*-15-*-*-*-*-*-*-*' <(echo "$1") &
}

tmpdir="$(mktemp -d)"
mkfifo "$tmpdir/fifo"
exec 3<> "$tmpdir/fifo"
rm -r "$tmpdir"

while true; do
    if battery_low; then
        run_osd_cat "Battery low: $perc_charge%"
    fi
    #sleep 5
    read -t 5 -u 3 nonevar
done
