#!/bin/bash

# Takes the output of the last command that you ran inside tmux and copies it to your system clipboard.
tac /tmp/my-tmux-capture.txt | awk '/~/{++n; next} n==1' | tac | head -n -1 | xclip -r -selection clipboard > /dev/null
sleep 0.1
exit 0
