#!/bin/bash
#
# kernel.tmux
#
# (c) Stephen Bates, 2018
#
# A tmux script to setup my favourite kernel compile
# environment. Includes panes for the compile plus htop and the
# icecream-sundae output.

SESSION=${SESSION:-$USER-kernel}

tmux -2 new-session -d -s $SESSION

tmux new-window -t $SESSION:1 -n 'Kernel Compile'
tmux split-window -v
tmux select-pane -t 1
tmux send-keys "icecream-sundae" C-m
tmux split-window -h
tmux send-keys "htop -C" C-m
tmux select-pane -t 0

# Set default window
tmux select-window -t $SESSION:1

# Attach to session
tmux -2 attach-session -t $SESSION
