#!/usr/bin/env sh

source=`cat` # collect standard input
sink=$(mktemp)

# send settings as command arguments or use default
settings=${@:-"--border --margin 3% --prompt 'select : '"}
fzf="fzf $settings"

sourcecommand="printf %s \""$(printf %s "$source")"\""

urxvt -name UrxvtFloat \
    -e sh -c           \
    "$sourcecommand | $fzf > $sink"

cat $sink
rm $sink
