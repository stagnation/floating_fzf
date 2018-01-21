#!/usr/bin/env sh

settings="--border --margin 3% --prompt 'launch : '"

listbins.sh | fzf_selector $settings | xargs start_independent_process.py
