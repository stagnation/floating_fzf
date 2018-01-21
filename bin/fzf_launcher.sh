#!/usr/bin/env sh

fzf="fzf --border --margin 3% --prompt 'launch : '"
bins="listbins.sh"
start="start_independent_process.py"

urxvt -name UrxvtFloat \
    -e sh -c           \
    "$bins | $fzf      \
    | xargs $start" 2>/dev/null
