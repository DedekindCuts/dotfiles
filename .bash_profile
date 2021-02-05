#!/bin/bash

# run .bashrc if it exists
[[ -r $HOME/.dotfiles/shell/bashrc ]] && . $HOME/.dotfiles/shell/bashrc

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

