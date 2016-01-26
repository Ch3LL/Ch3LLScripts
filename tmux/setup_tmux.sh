#!/bin/bash

SESSION=$USER
window1="M1"
window2="M2"
window3="min1"
window4="min2"
main_dir='~/vagrant/vagrant'

# Setup new session
tmux -2 new-session -d -s $SESSION

# Setup a window for tailing log files
tmux new-window -t $SESSION:1 -n $window1
tmux send-keys "cd $main_dir" C-m
tmux new-window -t $SESSION:2 -n $window2
tmux send-keys "cd $main_dir" C-m
tmux new-window -t $SESSION:3 -n $window3
tmux send-keys "cd $main_dir" C-m
tmux new-window -t $SESSION:4 -n $window4
tmux send-keys "cd $main_dir" C-m
