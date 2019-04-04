#!/bin/bash

# check if dock list exists
if [[ -r "$HOME/.dotfiles/.macos-settings/dock-list.txt" ]]; then
  # wipe the Dock
  defaults write com.apple.dock persistent-apps -array
  defaults write com.apple.dock persistent-other -array

  # add apps and directories in dock list to Dock
  IFS=";"
  echo "Adding apps and directories to Dock..."
	APP_STR='defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>$1</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"'
  DIR_STR='defaults write com.apple.dock persistent-others -array-add "<dict><key>tile-data</key><dict><key>displayas</key><integer>$2</integer><key>file-data</key><dict><key>_CFURLString</key><string>$1</string><key>_CFURLStringType</key><integer>0</integer></dict><key>showas</key><integer>$3</integer></dict><key>tile-type</key><string>directory-tile</string></dict>"'
  grep -v "^#" "$HOME/.dotfiles/.macos-settings/dock-list.txt" | while read -r LINE; do 
    read -ra SPLIT_LINE<<<"$LINE"
    if [[ ${#SPLIT_LINE[@]} == 1 ]]; then
      APP_PATH="${SPLIT_LINE[0]}"
      APP_PATH="${APP_PATH/'~'/$HOME}" # replace any instances of ~ or $HOME in the path with the actual $HOME path
      APP_PATH="${APP_PATH/'$HOME'/$HOME}" # replace any instances of ~ or $HOME in the path with the actual $HOME path
      sh -c "$APP_STR" -- "$APP_PATH"
    else
      DIR_PATH="${SPLIT_LINE[0]}"
      DIR_PATH="${DIR_PATH/'~'/$HOME}" # replace any instances of ~ or $HOME in the path with the actual $HOME path
      DIR_PATH="${DIR_PATH/'$HOME'/$HOME}" # replace any instances of ~ or $HOME in the path with the actual $HOME path
      DISPLAYAS="${SPLIT_LINE[1]}"
      SHOWAS="${SPLIT_LINE[2]}"
      sh -c "$DIR_STR" -- "$DIR_PATH" "$DISPLAYAS" "$SHOWAS"
    fi
	done
  killall Dock
  unset IFS
fi
