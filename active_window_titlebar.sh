#!/bin/sh

PIDFILE="/tmp/titlebar.pid"

MIN_WIDTH=2560
ALIGN=center

set_title() {
    id=`xprop -notype -root ':$0' _NET_ACTIVE_WINDOW`
    title=`xprop -notype -id ${id#*:} ':$0' WM_NAME`
    title=${title#*:\"}
    title=${title%\"}
}

escape_title() {
    set -f
    old_ifs=$IFS

    IFS=$1
    set -- $title

    title=$1
    shift 1
    for part in $@; do
        title="$title\\$IFS$part"
    done

    IFS=$old_ifs
    set +f
}

main_loop() {
    set_title
    escape_title '\'
    escape_title '"'
    printf ',[{"full_text":"%s","min_width":%d,"align":"%s"}]' "$title" $MIN_WIDTH $ALIGN
    kill -STOP $$
}

remove_pidfile() {
    rm $PIDFILE
    exit 0
}

trap main_loop SIGCONT
trap remove_pidfile 1 2 3 6

if [ -r $PIDFILE ]; then
    kill -CONT `cat $PIDFILE`
else
    echo $$ > $PIDFILE
    printf '{"version":1}[[]'
    main_loop
fi
