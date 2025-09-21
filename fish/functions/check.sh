#!/usr/bin/env bash

branch_name=$(basename $1)
session_name=$(tmux display-message -p "#S")
clean_name=$(echo $branch_name | tr "./" "__")
target="$session_name:$clean_name"

service=$2
left_command="make test-$service"
right_command="make fix-$service"

if ! tmux has-session -t $target 2> /dev/null; then
    tmux neww -dn $clean_name
    tmux split-window -h -t $clean_name
fi

shift

tmux send-keys -t $target.left "fj" C-m
tmux send-keys -t $target.right "fj" C-m

tmux send-keys -t $target.left "$left_command" C-m
tmux send-keys -t $target.right "$right_command" C-m
