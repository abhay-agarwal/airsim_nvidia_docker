# stop any existing 
tmux kill-session -t nvidia-docker || true

tmux new-session -s nvidia-docker -n htop -d
tmux send-keys -t nvidia-docker:0 "htop" C-m

# start from port 2
for PORT in 2 3 4 5 6 7 8 9; do
    tmux new-window -t nvidia-docker:$PORT -n instance-$PORT
    tmux send-keys -t nvidia-docker:$PORT "docker attach airsim-0$PORT" C-m
done

tmux select-window -t nvidia-docker:0
tmux attach-session -t nvidia-docker