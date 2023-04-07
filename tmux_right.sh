if [ "$(tmux display-message -p '#{pane_at_right}')" -ne 1 ]; then tmux select-pane -R; else tmux select-window -t:+1; fi
