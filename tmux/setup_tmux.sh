if [[ $USER != root ]]; then
    tmux_count=`tmux ls | wc -l`
    if [[ "$tmux_count" == "0" ]]; then
        SESSION=$USER

        windows=("triage" "triage1" "tests" "tests2" "tests3" "tests4" "TODO")
        counter=0

        # setup initial session
        tmux -2 new-session -d -s $SESSION

        # setup windows
        echo ${counter}
        for window in "${windows[@]}"; do
            echo $counter
            echo $window
            if [ ${counter} == 0 ]; then
                tmux rename-window -t $SESSION:0 $window
            else
                tmux new-window -t $SESSION:${counter} -n $window
            fi
            tmux send-keys "cd $main_dir" C-m
            counter=$((counter+1))
            done
    else
        if [[ -z "$TMUX" ]]; then
            if [[ "$tmux_count" == "1" ]]; then
                session_id=1
            else
                session_id=`echo $tmux_count`
            fi
        fi
    fi
fi
