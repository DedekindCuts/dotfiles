#!/bin/bash

# wipe the Dock
defaults write com.apple.dock persistent-apps -array

# add apps and directories in dock-list.txt (if it exists) to Dock
if [[ -r "$HOME/.dotfiles/.macos-settings/dock-list.txt" ]]; then
  IFS=";"
  echo "Adding apps and directories to Dock..."
	APP_STR='defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>$1</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"'
  DIR_STR='defaults write com.apple.dock persistent-others -array-add "<dict><key>tile-data</key><dict><key>displayas</key><integer>$2</integer><key>file-data</key><dict><key>_CFURLString</key><string>$1</string><key>_CFURLStringType</key><integer>0</integer></dict><key>showas</key><integer>$3</integer></dict><key>tile-type</key><string>directory-tile</string></dict>"'
  grep -v "^#" "$HOME/.dotfiles/.macos-settings/dock-list.txt" | while read -r LINE; do 
    read -ra SPLIT_LINE<<<"$LINE"
    if [[ ${#SPLIT_LINE[@]} == 1 ]]; then
      sh -c "$APP_STR" -- "$LINE"
    else
      DIR_PATH="${SPLIT_LINE[0]}"
      DISPLAYAS="${SPLIT_LINE[1]}"
      SHOWAS="${SPLIT_LINE[2]}"
      sh -c "$DIR_STR" -- "$DIR_PATH" "$DISPLAYAS" "$SHOWAS"
    fi
    killall Dock
	done
  unset IFS
	read -n1 -rsp $'Press any key to continue.\n'
fi
