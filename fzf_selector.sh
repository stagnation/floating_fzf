#!/usr/bin/env sh

source=`cat` # collect standard input
fzf="`which fzf` --border --margin 3% --prompt 'switch to : '"
sink=$(mktemp)

sourcecommand="printf %s \""$(printf %s "$source")"\""

urxvt -name UrxvtFloat \
    -e sh -c           \
    "$sourcecommand | $fzf > $sink"

cat $sink
