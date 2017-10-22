#!/usr/bin/env sh

fzf="/home/spill/.fzf/bin/fzf --border --margin 3% --prompt 'launch : '"
bins="/home/spill/dotfiles/bin/fzf_launcher/listbins.sh"
start="/home/spill/dotfiles/bin/fzf_launcher/start_independent_process.py"

urxvt -name UrxvtFloat \
    -e sh -c           \
    "$bins | $fzf      \
    | xargs $start" 2>/dev/null
