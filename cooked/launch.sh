#!/bin/bash

tmux new-session -s airsim -n vnc -d
tmux new-window -t airsim:1 -n sitl -c /home/unreal/Firmware

tmux send-keys -t airsim:1 "sudo ./build_posix_sitl_default/src/firmware/posix/px4 ~/Documents/px4_sitl_airsim" C-m
tmux send-keys -t airsim:0 "sudo rm -f /tmp/.X$PORT-lock; Xvnc :$PORT -rfbport 590$PORT -geometry 284x160 -SecurityTypes None" C-m
sleep 2

DISPLAY=:$PORT vglrun /home/unreal/Blocks/Binaries/Linux/Blocks-Linux-Shipping -FULLSCREEN -ResX 284 -ResY 160 -VSync
