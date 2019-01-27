#!/bin/bash
#
# perf.tmux
#
# (c) Stephen Bates, 2018
#
# A tmux script to setup my favourite perf compile
# environment. Includes panes for the compile plus htop and the
# distccmon-text output.

SESSION=${SESSION:-$USER-perf}

tmux -2 new-session -d -s $SESSION

tmux new-window -t $SESSION:1 -n 'Performance'
tmux split-window -v
tmux select-pane -t 0
tmux split-window -h
tmux send-keys "bmon" C-m
tmux select-pane -t 2
tmux send-keys "htop -C" C-m
tmux split-window -h
tmux send-keys "iostat -md 2" C-m
tmux select-pane -t 0

# Set default window
tmux select-window -t $SESSION:1

# Attach to session
tmux -2 attach-session -t $SESSION
