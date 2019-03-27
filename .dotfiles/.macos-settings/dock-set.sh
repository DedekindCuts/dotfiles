#!/bin/bash

# add apps in dock-list.txt (if it exists) to Dock
if [[ -r "$HOME/.dotfiles/.macos-settings/dock-list.txt" ]]; then
  echo "Adding apps to Dock..."
	grep -v "^#" "$HOME/.dotfiles/.macos-settings/dock-list.txt" | while read -r APP; do 
    CMD_STR='defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>$1</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"'
    sh -c "$CMD_STR" -- "$APP"
    killall Dock
	done
	read -n1 -rsp $'Press any key to continue.\n'
fi
