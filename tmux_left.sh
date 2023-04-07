if [ "$(tmux display-message -p '#{pane_at_left}')" -ne 1 ]; then tmux select-pane -L; else tmux select-window -t:-1; fi
