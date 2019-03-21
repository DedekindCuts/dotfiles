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

# set PATH
for x in "/Library/TeX/texbin" "/opt/X11/bin" "/usr/local/bin" "/usr/bin" "/bin" "/usr/local/sbin" "/usr/sbin" "/sbin"; do
	if echo $PATH | grep -q $x; then 
		:
	else 
		PATH=$PATH:$x
	fi
done

# run local bashrc if there is one
test -r ~/.bashrc.local && . ~/.bashrc.local
