#!/bin/bash

#GitHub username and repository (replace with your own if you have forked this repository and made changes)
USER="DedekindCuts"
REPO="dotfiles"
#the directory into which you would like to clone the repository
DIR=~
#Apple ID (used to download and update App Store apps)
APPLE_ID="nick.larsen100@gmail.com"

echo "Checking preliminaries..."
#check if Xcode command line tools are installed and install if not
if type xcode-select >&- && xpath=$( xcode-select --print-path ) && test -d "${xpath}" && test -x "${xpath}"; then
	echo "$(tput setaf 2)Xcode command line tools installed and up to date.$(tput setaf 7)"
else
	echo "Installing Xcode command line tools..."
	xcode-select --install
	echo "$(tput setaf 2)Installed.$(tput setaf 7)"
fi

#check if Homebrew is installed and install if not
if which brew >/dev/null; then
	#echo "$(tput setaf 2)Homebrew already installed.$(tput setaf 7)"
	#echo "Updating Homebrew..."
	brew update >/dev/null
	echo "$(tput setaf 2)Homebrew installed and up to date.$(tput setaf 7)"
else
	echo "Installing Homebrew..."
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	echo "$(tput setaf 2)Installed.$(tput setaf 7)"
fi

#check if Git (Homebrew) is installed and install if not
if brew ls --versions git >/dev/null; then
	#echo "$(tput setaf 2)Git already installed.$(tput setaf 7)"
	#echo "Updating Git..."
	if brew outdated | grep git; then
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

#clone GitHub dotfiles repository
echo "Downloading most recent version of dotfiles..."
if [ ! -d $DIR/Dotfiles ]; then
	git clone https://github.com/$USER/$REPO.git $DIR/Dotfiles &>/dev/null
else
	cd $DIR/Dotfiles
	git pull https://github.com/$USER/$REPO.git &>/dev/null
fi
echo "$(tput setaf 2)Downloaded.$(tput setaf 7)"
cd $DIR/Dotfiles

#check if backups of pre-existing dotfiles already exist and delete if so (with user confirmation)
if [ -d ~/.old_dotfiles ]; then
	tput setaf 9
	rm -Rf ~/.old_dotfiles
	tput setaf 7
fi
#create backup of existing dotfiles (not directories)
mkdir ~/.old_dotfiles
for file in ~/.*; do 
	if [ ! -d $file ]; then 
		mv -f $file ~/.old_dotfiles
	fi
done

#symlink files into ~
for file in dots/*; do
	ln -sf $PWD/$file ~/.${file##*dots/}
done

#sign in to App Store
echo "Signing in to App Store..."

#Workaround for mas signin bug
until (mas account > /dev/null); do 
	echo "$(tput setaf 3)Please sign in using the App Store app.$(tput setaf 7)" 
	open -a "/Applications/App Store.app"
	echo "$(tput setaf 3)Waiting for signin...$(tput setaf 7)"
	until (mas account > /dev/null); do 
		sleep 3
	done
done
##############################

#Normal signin (uncomment when mas bug is resolved)
#until (mas account > /dev/null); do
#	mas signin $APPLE_ID &>/dev/null
#done

if (mas account > /dev/null); then
	echo "$(tput setaf 2)Signed in.$(tput setaf 7)"
fi

#prompt for type of install
echo "What would you like to do?"
select answer in "Quick update currently installed programs" \
	"Install all programs" \
	"Selectively update or install programs";
do
	case $answer in
		"Quick update currently installed programs" )
			brew upgrade
			brew cask upgrade
			mas upgrade
			break;;
		"Install all programs" )
			brew bundle --file=Brewfile
			break;;
		"Selectively update or install programs" )
			(brew bundle list --taps --file=Brewfile | while read -r tap ; do
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
			(brew bundle list --brews --file=Brewfile | while read -r brew ; do
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
			(brew bundle list --casks --file=Brewfile | while read -r cask ; do
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
			#silently install GNU grep if not already installed (GNU grep is required for extracting the mas ids and names from the mas_list file)
			(if brew ls --versions grep > /dev/null; then :; else brew install grep &> /dev/null; fi
			cat mas_list | while read -r mas ; do
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
			#upgrade all installed brews and casks (doing them individually gives an error for brews and uninstalls and reinstalls for casks)
			echo "Updating..."
			brew upgrade
			brew cask upgrade
			mas upgrade
			break;;
	esac
done

#prompt for cleanup
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

#install Sublime Text settings
rm -r ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
ln -sfF $PWD/Sublime/User ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/

#Enable opening Sublime Text from the terminal
ln -sfF "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/sublime

#source .macos file to apply system-wide settings and preferences
echo "Would you like to apply custom macOS settings? (Requires password and restart)"
select answer in "Yes" "No"
do
	case $answer in
		Yes )
			source ~/.macos
			break;;
		No )
			break;;
	esac
done
