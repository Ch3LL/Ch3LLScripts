#!/bin/bash
SESSION=$USER

windows=("triage" "triage1" "tests" "tests2" "tests3" "tests4" "TODO")
counter=0

# setup initial session
tmux -2 new-session -d -s $SESSION

# setup windows
for window in "${windows[@]}"; do
    if [ ${counter} == 0 ]; then
        tmux rename-window -t $SESSION:0 $window
    else
        tmux new-window -t $SESSION:${counter} -n $window
    fi
    tmux send-keys "cd $main_dir" C-m
    counter=$((counter+1))
done
