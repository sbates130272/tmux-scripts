#!/bin/bash
#
# fio.tmux
#
# (c) Stephen Bates, 2018
#
# A tmux script to setup my favourite fio testing script.

SESSION=${SESSION:-$USER-fio}

tmux -2 new-session -d -s $SESSION

# Setup a window for tailing log files
tmux new-window -t $SESSION:1 -n 'NVMe-oF Host'
tmux split-window -v
tmux select-pane -t 1
tmux send-keys "htop -C" C-m
tmux split-window -h
tmux send-keys "iostat -md 2" C-m
tmux split-window -v
tmux send-keys "dmesg -w" C-m

# Set default window
tmux select-window -t $SESSION:1
tmux select-pane -t 0
tmux send-keys "fio --version" C-m

# Attach to session
tmux -2 attach-session -t $SESSION
