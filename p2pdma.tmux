#!/bin/bash
#
# kernel.tmux
#
# (c) Stephen Bates, 2018
#
# A tmux script to setup my favourite kernel compile
#environment. Includes panes for the compile plus htop and the
#distccmon-text output.

SESSION=${SESSION:-$USER-p2pdma}

tmux -2 new-session -d -s $SESSION

# Setup a window for tailing log files
tmux new-window -t $SESSION:1 -n 'p2pdma testing'
tmux split-window -v
tmux select-pane -t 1
tmux send-keys "htop -C" C-m
tmux split-window -h
tmux send-keys "iostat -md 2 /dev/nvme*" C-m
tmux select-pane -t 0
tmux split-window -h
tmux send-keys "watch -n 2 cat /sys/class/p2pmem_device/p2pmem0/device/p2pmem/available" C-m

# Set default window
tmux select-window -t $SESSION:1
tmux select-pane -t 0
tmux send-keys "sudo nvme list" C-m

# Attach to session
tmux -2 attach-session -t $SESSION
