#!/bin/bash
#
# zfs.tmux
#
# (c) Stephen Bates, 2018
#
# A tmux script to setup my a nice environment for ZFS testing.
# Run this from the top level of the Eideticom ZFS git repo.


SESSION=${SESSION:-$USER-zfs}

tmux -2 new-session -d -s $SESSION

# Setup a window for tailing log files
tmux new-window -t $SESSION:1 -n 'Eideticom ZFS Development'
tmux split-window -v
tmux select-pane -t 1
tmux send-keys "htop -C" C-m
tmux split-window -h
tmux send-keys "iostat -md 2 /dev/nvme*" C-m
tmux split-window -v
tmux send-keys "watch -n 3 './eideticom/stats'" C-m
tmux select-pane -t 0
tmux split-window -h
tmux send-keys "./cmd/zpool/zpool iostat -v 5" C-m
tmux select-pane -t 2
tmux split-window -v
tmux send-keys "watch -n 1 'dmesg | tail'" C-m

# Set default window
tmux select-window -t $SESSION:1
tmux select-pane -t 0
tmux send-keys "./cmd/zpool/zpool list -v" C-m

# Attach to session
tmux -2 attach-session -t $SESSION
