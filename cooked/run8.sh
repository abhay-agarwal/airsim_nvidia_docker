#!/bin/bash
set -e
if [ ! -d "LinuxNoEditor" ] ; then
    echo "You have not built and run the docker from the build script. Exiting"
    exit 1
fi

docker build -t airsim-linux .

tmux new-session -s nvidia-docker -n htop -d
for PORT in 1 2 3 4 5 6 7 8; do
    tmux new-window -t nvidia-docker:$PORT -n instance$PORT
    tmux send-keys -t nvidia-docker:$PORT "PORT=$PORT sh docker.sh"
done

tmux send-keys -t nvidia-docker:0 "htop"
tmux select-window -t nvidia-docker:0
tmux attach-session -t nvidia-docker