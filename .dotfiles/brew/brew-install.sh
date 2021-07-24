#!/bin/sh

# check if Homebrew is installed and install if not
if command -v brew >/dev/null; then
	# echo "$(tput setaf 2)Homebrew already installed.$(tput setaf 7)"
	# echo "Updating Homebrew..."
	brew update >/dev/null
	echo "$(tput setaf 2)Homebrew installed and up to date.$(tput setaf 7)"
else
	echo "Installing Homebrew..."
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	echo "$(tput setaf 2)Installed.$(tput setaf 7)"
fi

# check if Git (Homebrew) is installed and install if not
if brew ls --versions git >/dev/null; then
	if brew outdated | grep git >/dev/null; then
		echo "Updating Git..."
		brew upgrade git >/dev/null
	else
		:
	fi
	echo "$(tput setaf 2)Git installed and up to date.$(tput setaf 7)"
else
	echo "Installing Git..."
	brew install git
	echo "$(tput setaf 2)Installed.$(tput setaf 7)"
fi

# install from Brewfile
brew bundle --file="$HOME/.dotfiles/brew/Brewfile"

# sign in to App Store
if ! mas account >/dev/null; then
    echo "Please open App Store and sign in using your Apple ID ...."
    until mas account >/dev/null; do
        sleep 5
    done
fi

# update
brew upgrade
if command -v mas >/dev/null; then
	mas upgrade
fi
