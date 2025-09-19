#!/bin/bash

set -e

PENCIL_HOME="/home/kishore/Documents/Pencil-MHD/pencil-code"
state_file="$HOME/.local/share/pc_check_commits"

date_now="$(date --iso-8601=seconds)"

if test -e "$state_file"; then
	git -C "$PENCIL_HOME" fetch
	
	date_last="$(cat $state_file)"
	git dag -r "$PENCIL_HOME" --since "$date_last" -b origin/master
fi

echo "$date_now" > "$state_file"
