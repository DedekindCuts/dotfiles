#!/bin/bash

if [[ -r "$HOME/.dotfiles/.installs/manual" ]]; then
	IFS=";"
	echo "$(tput setaf 3)Recommended programs to install (if not installed already):$(tput setaf 7)"
	grep -v "^#" "$HOME/.dotfiles/.installs/manual" | while read -r LINE; do 
		read -ra SPLIT_LINE <<<"$LINE"
		PROGRAM_NAME="${SPLIT_LINE[0]}"
		PROGRAM_URL="${SPLIT_LINE[1]}"
		echo -e "\t$PROGRAM_NAME: $PROGRAM_URL"
	done
	unset IFS
	read -n1 -rsp $'Press any key to continue.\n'
fi
