#!/bin/bash
SESSION='default'

if ! tmux has-session -t "$SESSION" 2>/dev/null; then
    # Create a new session named "my_session"
    tmux new-session -d -s default -n "main"

    # Create additional windows
    tmux new-window -t default:2 -n "yazi"
    tmux new-window -t default:3 -n "three"
    tmux new-window -t default:4 -n "notes"

    # Split the first window into panes
    tmux split-window -h -t default:3
    tmux split-window -v -t default:3.1

    # Run commands in panes/windows
    tmux send-keys -t default:1.0 "cd ~" C-m
    tmux send-keys -t default:2 "y" C-m
    tmux send-keys -t default:4 "nvim ~/fast_notes.md" C-m

    # Select the first window and attach
    tmux select-window -t default:1
fi
tmux attach -t default
