#!/usr/bin/env sh

settings="--color=light --header 'launch'"

listbins.sh | fzf_selector.sh $settings | xargs start_independent_process.py
