#!/bin/bash

#custom prompt
source ~/.bash_prompt

# Store multiline commands as one line.
shopt -s cmdhist

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set preferred text editor
export EDITOR="code -n -w"
export GIT_EDITOR=$EDITOR
export VISUAL=$EDITOR

# set custom aliases
test -r ~/.shell-aliases && . ~/.shell-aliases

# enable colorized terminal output
if which gdircolors >/dev/null; then
    test -r ~/.dircolors && eval "$(gdircolors -b ~/.dircolors)" || eval "$(gdircolors -b)"
fi

PATH_LOCATIONS=( "/usr/local/bin" "/usr/bin" "/bin" "/usr/local/sbin" "/usr/sbin" "/sbin" )

# set PATH
for x in "${PATH_LOCATIONS[@]}"; do
	if echo $PATH | grep -q $x; then 
		:
	else 
		PATH=$PATH:$x
	fi
done

# check if X11 is installed; if so, add it to PATH if it's not already
if which xdpyinfo >/dev/null; then
	if echo $PATH | grep -q "/opt/X11/bin"; then
		:
	else
		PATH=$PATH:"/opt/X11/bin"
	fi
fi

# check if TeX is installed; if so, add it to PATH if it's not already
if which tex >/dev/null; then
	if echo $PATH | grep -q "/Library/TeX/texbin"; then
		:
	else
		PATH=$PATH:"/Library/TeX/texbin"
	fi
fi

# check if conda is installed; if so, add it to PATH if it's not already
if which conda >/dev/null; then
	for x in "$MINICONDA_PATH/bin" "$MINICONDA_PATH/condabin"; do
		if echo $PATH | grep -q $x; then
			:
		else
			PATH=$PATH:$x
		fi
	done

	# put conda at the front of PATH if we're in a vscode integrated terminal AND 
	# it's not already (so any python installations from a conda environment will 
	# be preferred to the system python)
	if [[ "$TERM_PROGRAM" = "vscode" ]] && ! (echo $PATH | grep -q "^$MINICONDA_PATH/bin"); then
	    PATH="$MINICONDA_PATH/bin:$PATH"
	fi
	# conda init code

	## added by Miniconda3 4.5.12 installer
	## >>> conda init >>>
	## !! Contents within this block are managed by 'conda init' !!
	#__conda_setup="$(CONDA_REPORT_ERRORS=false '/Users/nicklarsen/miniconda/bin/conda' shell.bash hook 2> /dev/null)"
	#if [ $? -eq 0 ]; then
	#    \eval "$__conda_setup"
	#else
	#    if [ -f "/Users/nicklarsen/miniconda/etc/profile.d/conda.sh" ]; then
	#        . "/Users/nicklarsen/miniconda/etc/profile.d/conda.sh"
	#        CONDA_CHANGEPS1=false conda activate base
	#    else
	#        \export PATH="/Users/nicklarsen/miniconda/bin:$PATH"
	#    fi
	#fi
	#unset __conda_setup
	## <<< conda init <<<
fi

# run local bashrc if there is one
test -r ~/.bashrc.local && . ~/.bashrc.local
