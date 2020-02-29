#!/bin/bash
#
# docker.tmux
#
# (c) Stephen Bates, 2020
#
# A tmux script to setup my favourite docker command line
# environment. Includes panes for docker ps plus htop and a terminal
# for accessing running containers.

SESSION=${SESSION:-$USER-docker}

tmux -2 new-session -d -s $SESSION

tmux new-window -t $SESSION:1 -n 'Docker'
tmux split-window -v -p 50
tmux select-pane -t 0
tmux split-window -h -p 50
tmux select-pane -t 1
tmux send-keys "watch -n 5 docker ps" C-m
tmux split-window -v -p 50
tmux send-keys "htop -C" C-m

# Set default window
tmux select-window -t $SESSION:1
tmux select-pane -t 0
tmux send-keys "docker images | head -n 20" C-m
tmux send-keys "echo" C-m
tmux send-keys "echo" C-m
tmux send-keys "echo docker run -it \<container name\> /bin/bash" C-m

# Attach to session
tmux -2 attach-session -t $SESSION
