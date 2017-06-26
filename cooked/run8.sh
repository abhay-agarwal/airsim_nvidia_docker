#!/bin/bash
set -e
if [ ! -d "LinuxNoEditor" ] ; then
    echo "You have not built and run the docker from the build script. Exiting"
    exit 1
fi

docker build -t airsim-linux .

tmux kill-session -t nvidia-docker
tmux new-session -s nvidia-docker -n htop -d

# start from port 2
for PORT in 2 3 4 5 6 7 8 9; do
    tmux new-window -t nvidia-docker:$PORT -n instance$PORT
    tmux send-keys -t nvidia-docker:$PORT "PORT=$PORT sh docker.sh" C-m
done

tmux send-keys -t nvidia-docker:0 "htop" C-m
tmux select-window -t nvidia-docker:0
tmux attach-session -t nvidia-docker