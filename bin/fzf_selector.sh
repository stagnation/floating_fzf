#!/usr/bin/env sh

# set your FLOAT_TERM env var to adjust how the new term is spawned
term=${FLOAT_TERM:-"urxvt -name UrxvtFloat"}

sink=$(mktemp)
store=$(mktemp)

# On signals, do cleanup and exit with error
cleanup()
{
    rm "$sink"
    rm "$store"
    exit 1
}
trap cleanup 1 2 3 6
# 1 SIGHUP  Clean tidyup
# 2 SIGINT  Interrupt
# 3 SIGQUIT Quit
# 6 SIGABRT Abort

# send settings as command arguments or use default
settings=${@:-"--border --margin 3% --prompt 'select : '"}
fzf="fzf $settings"

# collect standard input
cat > $store

$(
    $term    \
    -e sh -c \
    "cat $store | $fzf > $sink"
)

cat "$sink"
cleanup
