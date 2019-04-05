#!/bin/bash

if [[ -r "$HOME/.dotfiles/installs/manual" ]]; then
	IFS=";"
	grep -v "^#" "$HOME/.dotfiles/installs/manual" | while read -r LINE; do 
		read -ra SPLIT_LINE <<<"$LINE"
		PROGRAM_NAME="${SPLIT_LINE[0]}"
		PROGRAM_PATH="${SPLIT_LINE[1]}"
		PROGRAM_URL="${SPLIT_LINE[2]}"
		if [[ ! -e "$PROGRAM_PATH" ]]; then
			echo -e "$PROGRAM_NAME not found at $PROGRAM_PATH\n\t$PROGRAM_URL" >> "$OUTPUT_FILEPATH"
		fi
	done
	unset IFS
fi
