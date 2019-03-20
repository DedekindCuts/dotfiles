#!/bin/bash

#aliases
alias showHiddenFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideHiddenFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

#custom prompt
source ~/.bash_prompt

#set PATH
for x in "/Users/n.larsen/miniconda3/bin" "/Users/n.larsen/miniconda3/condabin" "/usr/local/share/dotnet" "~/.dotnet/tools" "/Library/TeX/texbin" "/opt/X11/bin" "/usr/local/bin" "/usr/bin" "/bin" "/usr/local/sbin" "/usr/sbin" "/sbin"; do
	if echo $PATH | grep -q $x; then 
		:
	else 
		PATH=$PATH:$x
	fi
done

#put conda at the front of PATH if it's not already (so any python installations from a conda environment will be preferred to the system python)
if echo $PATH | grep -q "/Users/n.larsen/miniconda3/bin"; then
    PATH="/Users/n.larsen/miniconda3/bin:$PATH"
fi

EDITOR="subl -w"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/n.larsen/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/n.larsen/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/n.larsen/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/n.larsen/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
