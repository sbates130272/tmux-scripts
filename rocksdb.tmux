#!/bin/bash
#
# perf.tmux
#
# (c) Stephen Bates, 2018
#
# A tmux script to setup my favourite rocksdb
# environment. Includes panes for the compile plus htop and the
# distccmon-text output.

SESSION=${SESSION:-$USER-rocksdb}
DIR=${DIR:-/mnt/xfs/rocksdb}

tmux -2 new-session -d -s $SESSION

tmux new-window -t $SESSION:1 -n 'RocksDB'
tmux split-window -v
tmux select-pane -t 0
tmux split-window -h
tmux split-window -v -p 50
tmux select-pane -t 1
tmux send-keys "dmesg -w" C-m
tmux select-pane -t 2
tmux send-keys "watch -n 3 du -h --max-depth=1 ${DIR}" C-m
tmux select-pane -t 3
tmux send-keys "htop -C" C-m
tmux split-window -h
tmux send-keys "iostat -md 2" C-m
tmux select-pane -t 0

# Set default window
tmux select-window -t $SESSION:1

# Attach to session
tmux -2 attach-session -t $SESSION
