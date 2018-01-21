#!/usr/bin/env sh

# set your FLOAT_TERM env var to adjust how the new term is spawned
term=${FLOAT_TERM:-"urxvt -name UrxvtFloat"}

sink=$(mktemp)
store=$(mktemp)

# send settings as command arguments or use default
settings=${@:-"--border --margin 3% --prompt 'select : '"}
fzf="fzf $settings"

cat > $store

$($term \
    -e sh -c           \
    "cat $store | $fzf > $sink"
)

cat "$sink"

rm "$sink"
rm "$store"
