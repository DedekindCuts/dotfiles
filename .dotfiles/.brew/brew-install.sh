#!/bin/bash

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

# sign in to App Store if MAS is being used
if command -v mas >/dev/null; then
	echo "Signing in to App Store..."

	# Workaround for mas signin bug
	until (mas account > /dev/null); do 
		echo "$(tput setaf 3)Please sign in using the App Store app.$(tput setaf 7)" 
		open -a "/Applications/App Store.app"
		echo "$(tput setaf 3)Waiting for signin...$(tput setaf 7)"
		until (mas account > /dev/null); do 
			sleep 3
		done
	done
	##############################

	# Normal signin (uncomment if/when mas bug is resolved)
	# until (mas account > /dev/null); do
	#	mas signin $APPLE_ID &>/dev/null # will need to set APPLE_ID if this ever works
	# done

	if (mas account > /dev/null); then
		echo "$(tput setaf 2)Signed in.$(tput setaf 7)"
	fi
fi

# install from Brewfile
brew bundle --file=$HOME/.dotfiles/.brew/.Brewfile

# update
brew upgrade
brew cask upgrade
if command -v mas >/dev/null; then
	mas upgrade
fi
