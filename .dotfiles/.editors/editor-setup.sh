#!/bin/bash

echo "Setting up preferred text editor..."

if [[ $PREFERRED_EDITOR == "sublime" ]]; then
  # prompt to install Sublime if it is not found
  while [[ ! -d "$HOME/Library/Application Support/Sublime Text 3" ]]; do
    if [[ -e "/Applications/Sublime Text.app" ]]; then
      open "/Applications/Sublime Text.app"
    else
      echo "Before continuing, Sublime Text must be installed."
      echo "(https://www.sublimetext.com/)"
      read -n1 -rsp $'Press any key to continue once Sublime is installed, or CTRL+C to exit.\n'
    fi
  done

  #Enable opening Sublime Text from the terminal
  ln -sfF "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" "/usr/local/bin/sublime"

  #install Sublime Text settings
  rm -r "$HOME/Library/Application Support/Sublime Text 3/Packages/User"
  ln -sfF "$HOME/.dotfiles/.editors/Sublime/User" "$HOME/Library/Application Support/Sublime Text 3/Packages"
elif [[ $PREFERRED_EDITOR == "vscode" ]]; then
  # prompt to install VS code if it is not found
  while [[ ! -d "$HOME/Library/Application Support/Code" ]]; do
    if [[ -e "/Applications/Visual Studio Code.app" ]]; then
      open "/Applications/Visual Studio Code.app"
    else
      echo "Before continuing, VS Code must be installed."
      echo "(https://code.visualstudio.com/download)"
      read -n1 -rsp $'Press any key to continue once VS Code is installed, or CTRL+C to exit.\n'
    fi
  done

  # add VS Code to PATH to allow launching from the terminal (using `code`)
  # (if it's installed and not already in PATH)
  if [[ -e "/Applications/Visual Studio Code.app" ]]; then
    if echo $PATH | grep -q "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"; then
      :
    else
      PATH=$PATH:"/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
    fi
  else
    echo "Couldn't find '/Applications/Visual Studio Code.app'; check that is installed correctly and try again"
    exit
  fi

  ## apply custom VS Code settings
  ln -sfF "$HOME/.dotfiles/.editors/.vscode/snippets" "$HOME/Library/Application Support/Code/User"
  ln -sfF "$HOME/.dotfiles/.editors/.vscode/keybindings.json" "$HOME/Library/Application Support/Code/User"
  ln -sfF "$HOME/.dotfiles/.editors/.vscode/settings.json" "$HOME/Library/Application Support/Code/User"

  ## install VS Code extensions
  cat "$HOME/.dotfiles/.editors/.vscode/extensions-list.txt" | xargs -L 1 code --install-extension
else
  echo "Preferred text editor \"$PREFERRED_EDITOR\" is not currently supported; editor setup was not performed" >> OUTPUT_FILEPATH
fi
