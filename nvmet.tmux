#!/bin/bash
#
# nvmet.tmux
#
# (c) Stephen Bates, 2018
#
# A tmux script to setup my favourite NVMe-oF fabrics target 
# environment. Includes panes for command entry plus a watch on the
# sysfs tree, dmesg and the block devices in the system.


SESSION=${SESSION:-$USER-nvmet}

tmux -2 new-session -d -s $SESSION

# Setup a window for tailing log files
tmux new-window -t $SESSION:1 -n 'NVMe-oF Target'
tmux split-window -v
tmux select-pane -t 1
tmux send-keys "htop -C" C-m
tmux split-window -h
tmux send-keys "iostat -md 2" C-m
tmux split-window -v
tmux send-keys "watch -n 2 'dmesg | tail'" C-m
tmux select-pane -t 0
tmux split-window -h
tmux send-keys "watch -n 2 tree /sys/kernel/config/nvmet" C-m

# Set default window
tmux select-window -t $SESSION:1
tmux select-pane -t 0
tmux send-keys "sudo nvme list" C-m

# Attach to session
tmux -2 attach-session -t $SESSION
