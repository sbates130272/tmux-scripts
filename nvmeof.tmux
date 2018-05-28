#!/bin/bash
#
# nvmeof.tmux
#
# (c) Stephen Bates, 2018
#
# A tmux script to setup my favourite NVMe-oF settings and print
# salient stats on block and network devices in the system.

SESSION=${SESSION:-$USER-nvmeof}

tmux -2 new-session -d -s $SESSION

tmux new-window -t $SESSION:1 -n 'NVMe over Fabrics'
tmux split-window -v
tmux select-pane -t 1
tmux send-keys "iostat -m -d 3" C-m
tmux split-window -h
tmux send-keys "htop" C-m

# Set default window
tmux select-window -t $SESSION:1

# Attach to session
tmux -2 attach-session -t $SESSION
