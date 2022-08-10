# Customize PS1
red=$(tput setaf 1)
green=$(tput setaf 2)
blue=$(tput setaf 4)
reset=$(tput sgr0)

# \h is the machine name
PS1='\[$blue\]\u\[$reset\]@\[$green\]\h\[$reset\]:\[$red\]\w\[$reset\]\$ '

# Enable vim key bindings
set -o vi

# Needed for lightline, vim colors and other pretty things
export TERM=xterm-256color

# Nice diff
function nd() {
    git diff $@ | vim -R -
}

# Auto generated from fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
