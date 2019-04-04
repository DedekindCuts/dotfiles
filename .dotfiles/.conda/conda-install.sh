#!/bin/bash

# TODO: check if Conda is installed by looking for appropriate folders, not 
# just `command -v conda`, since that will fail if for some reason conda has 
# not been added to PATH

# update conda if it already exists and if not, install it
if command -v conda >/dev/null; then
  echo "Updating Conda..."
	conda update -y conda >/dev/null
	echo "$(tput setaf 2)Conda installed and up to date.$(tput setaf 7)"
else
	echo "Installing Conda..."
	curl -fsSL $CONDA_INSTALLER -o $HOME/Downloads/conda.sh
	bash $HOME/Downloads/conda.sh -p $CONDA_DEST
	rm $HOME/Downloads/conda.sh
	echo "$(tput setaf 2)Installed.$(tput setaf 7)"
fi
