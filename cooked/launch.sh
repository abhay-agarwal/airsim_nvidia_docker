#!/bin/bash

tmux new-session -s airsim -n vnc -d
tmux new-window -t airsim:1 -n sitl -c /home/unreal/Firmware
tmux new-window -t airsim:2 -n sim -c /home/unreal/Blocks/Binaries/Linux/

tmux send-keys -t airsim:1 "sudo ./build_posix_sitl_default/src/firmware/posix/px4 ~/Documents/px4_sitl_airsim" C-m
sleep 5
tmux send-keys -t airsim:0 "Xvnc :PORT -rfbport 590$PORT -geometry 284x160 -SecurityTypes None" C-m
sleep 1
tmux send-keys -t airsim:2 "DISPLAY=:$PORT vglrun ./Blocks-Linux-Shipping -FULLSCREEN -ResX 284 -ResY 160 -VSync" C-m

tmux select-window -t airsim:1
tmux attach-session -t airsim

