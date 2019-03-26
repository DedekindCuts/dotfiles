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

# sign in to App Store
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

# prompt for type of install
echo "What would you like to do?"
select answer in "Quick update currently installed programs" \
	"Install all programs from Brewfile" \
	"Selectively update or install programs";
do
	case $answer in
		"Quick update currently installed programs" )
			brew upgrade
			brew cask upgrade
			mas upgrade
			break;;
		"Install all programs" )
			brew bundle --file=$HOME/.brew/.Brewfile
			break;;
		"Selectively update or install programs" )
			(brew bundle list --taps --file=$HOME/.brew/.Brewfile | while read -r tap ; do
				echo "Tap $tap?"
				select answer in "Yes" "No"
				do
					case $answer in
						Yes )
							brew tap "$tap"
							break;;
						No )
							break;;
					esac
				done <&4
			done) 4<&0
			(brew bundle list --brews --file=$HOME/.brew/.Brewfile | while read -r brew ; do
				echo "Install/upgrade $brew?"
				select answer in "Yes" "No"
				do
					case $answer in
						Yes )
							if brew ls --versions "$brew" > /dev/null; then
								echo "Already installed; updating."
							else
								brew install "$brew"
							fi
							break;;
						No )
							break;;
					esac
				done <&4
			done) 4<&0
			(brew bundle list --casks --file=$HOME/.brew/.Brewfile | while read -r cask ; do
				echo "Install/upgrade $cask?"
				select answer in "Yes" "No"
				do
					case $answer in
						Yes )
							if brew cask ls --versions "$cask" > /dev/null; then
								echo "Already installed; updating."
							else
								brew cask install "$cask"
							fi
							break;;
						No )
							break;;
					esac
				done <&4
			done) 4<&0
			# silently install GNU grep if not already installed (GNU grep is required for extracting the mas ids and names from the mas_list file)
			(if brew ls --versions grep > /dev/null; then :; else brew install grep &> /dev/null; fi
			cat $HOME/.brew/.mas-list | while read -r mas ; do
				id="$(echo $mas | ggrep -oP '^\d+')"
				name="$(echo $mas | ggrep -oP '(?<=\h)[\w\h\d-:]*')"
				echo "Install/upgrade $name?"
				select answer in "Yes" "No"
				do
					case $answer in
						Yes )
							if mas list | grep "$id" &> /dev/null; then 
								echo "Already installed; updating."
							else 
								mas install "$id"
							fi
							break;;
						No )
							break;;
					esac
				done <&4
			done) 4<&0
			# upgrade all installed brews and casks (doing them individually gives an error for brews and uninstalls and reinstalls for casks)
			echo "Updating..."
			brew upgrade
			brew cask upgrade
			mas upgrade
			break;;
	esac
done

# prompt for cleanup
echo "Would you like to clean up by removing old versions of programs?"
select answer in "Yes" "No"
do
	case $answer in
		Yes )
			brew cleanup
			break;;
		No )
			break;;
	esac
done
