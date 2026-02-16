#!/bin/bash

# Takes the output of the last command that you ran inside tmux and copies it to your system clipboard.
# Works both locally (via xclip) and over SSH (via OSC 52 escape sequence).

CONTENT=$(tac /tmp/my-tmux-capture.txt | awk '/~/{++n; next} n==1' | tac | head -n -1)

# Remove trailing newline for cleaner clipboard content
CONTENT=$(printf '%s' "$CONTENT")

if [ -n "$SSH_CONNECTION" ] || [ -z "$DISPLAY" ]; then
    # Remote session (or no X11 display): use OSC 52 escape sequence.
    # This tells the *local* terminal emulator to set its clipboard.
    # Works in iTerm2, Alacritty, kitty, WezTerm, Windows Terminal, etc.
    ENCODED=$(printf '%s' "$CONTENT" | base64 | tr -d '\n')

    # Write the OSC 52 sequence directly to the tmux client's TTY.
    # This bypasses tmux's escape-sequence filtering so the sequence
    # reaches the outer terminal even on tmux <3.3 (no allow-passthrough).
    if [ -n "$TMUX" ]; then
        TTY=$(tmux display-message -p '#{client_tty}')
        printf '\e]52;c;%s\a' "$ENCODED" > "$TTY"
    else
        printf '\e]52;c;%s\a'  "$ENCODED"
    fi
else
    # Local session with X11: use xclip as before.
    printf '%s' "$CONTENT" | xclip -r -selection clipboard > /dev/null
fi

sleep 0.1
exit 0
