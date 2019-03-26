#!/bin/bash

# TODO: check if Conda is installed by looking for appropriate folders, not 
# just `which conda`, since that will fail if for some reason conda has not
# been added to PATH

# install conda
if which conda >/dev/null; then
	echo "Installing Conda..."
	curl -fsS $CONDA_INSTALLER -o $HOME/Downloads/conda.sh
	bash $HOME/Downloads/conda.sh -p $CONDA_DEST
	rm $HOME/Downloads/conda.sh
	echo "$(tput setaf 2)Installed.$(tput setaf 7)"
else
  echo "Updating Conda..."
	conda update conda >/dev/null
	echo "$(tput setaf 2)Conda installed and up to date.$(tput setaf 7)"
fi
