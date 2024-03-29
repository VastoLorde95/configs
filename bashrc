# hello pathmunge
pathmunge () {
    if ! echo $PATH | /bin/egrep -q "(^|:)$1($|:)" ; then
        if [ "$2" = "after" ] ; then
            PATH=$PATH:$1
        else
            PATH=$1:$PATH
        fi
    fi
}

# munge some paths
pathmunge "~/bin"

# Set editor
export EDITOR=nvim

# Enable vim key bindings
set -o vi

# aliases
alias vim=nvim
alias rl='readlink -f'

# Needed for lightline, vim colors and other pretty things
export TERM=xterm-256color
export LC_ALL="en_US.UTF-8"

# Nice diff
function nd() {
    git diff $@ | vim -R -
}

# FZF
source /usr/share/doc/fzf/examples/key-bindings.bash
source /usr/share/bash-completion/completions/fzf

export FZF_ALT_C_OPTS="--preview 'echo {}' --preview-window down:5:hidden:wrap --bind '?:toggle-preview'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:5:hidden:wrap --bind '?:toggle-preview'"
export FZF_DEFAULT_OPTS="--height=20% --layout=reverse --info=inline"
FZF_CTRL_R_EDIT_KEY=ctrl-e
FZF_CTRL_R_EXEC_KEY=enter

# bye bye pathmunge
unset pathmunge    
