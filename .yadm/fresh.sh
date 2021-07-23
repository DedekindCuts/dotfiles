# one-and-done script for setting up dotfiles on a new computer
# doesn't make any assumptions about installed programs

# set the location of the dotfiles repo to clone from
DOTFILES_REPO="https://github.com/DedekindCuts/dotfiles.git"

# first install Xcode command line tools if they aren't already
if type xcode-select >&- && xpath=$( xcode-select --print-path ) && test -d "${xpath}" && test -x "${xpath}"; then
	echo "$(tput setaf 2)Xcode command line tools installed and up to date.$(tput setaf 7)"
else
	echo "Installing Xcode command line tools..."
	xcode-select --install
	echo "$(tput setaf 2)Installed.$(tput setaf 7)"
fi

# create /usr/local/bin if it doesn't exist already
if [[ ! -d /usr/local/bin ]]; then
	echo "Creating /usr/local/bin..."
  if [[ $ADMIN_USERNAME != $USER ]]; then
		su $ADMIN_USERNAME -c 'sudo mkdir /usr/local/bin'
	else
		sudo mkdir /usr/local/bin
	fi
fi

# add /usr/local/bin to PATH if it isn't there already
if echo $PATH | grep -q "/usr/local/bin"; then 
	:
else 
	PATH=$PATH:"/usr/local/bin"
fi

# then download and install yadm in /usr/local/bin
echo "Installing yadm..."
if [[ $ADMIN_USERNAME != $USER ]]; then
	su $ADMIN_USERNAME -c 'sudo curl -fsSLo /usr/local/bin/yadm https://github.com/TheLocehiliosan/yadm/raw/master/yadm && sudo chmod a+x /usr/local/bin/yadm'
else
	sudo curl -fsSLo /usr/local/bin/yadm https://github.com/TheLocehiliosan/yadm/raw/master/yadm && sudo chmod a+x /usr/local/bin/yadm
fi

# finally, use yadm to set up dotfiles
cd $HOME
yadm clone $DOTFILES_REPO --bootstrap
