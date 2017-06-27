airsim_nvidia_docker
====================

This is the library to set up AirSim inside of a docker container for portable testing, for example in running an [A3C-LSTM Reinforcement Learning algorithm](https://github.com/abhay-agarwal/reinforce/tree/airsim).

You must have the following:

Docker 1.17
Nvidia-Docker (get it [here](https://github.com/NVIDIA/nvidia-docker))
NVIDIA-Linux-x86_64-381.22.run (download into root directory from NVIDIA)
UnrealEngine-4.15.zip (Requires signup with Epic Games. Once signed up, go to https://github.com/EpicGames/UnrealEngine/tree/4.15 and click Download ZIP then place in this root directory)

Then, run `run.sh`. The build should take approximately an hour (or more depending on your network connection). Fortunately, this only needs to happen once.

Then, go to the cooked directory, which should now have a directory with your completed linux binary called `LinuxNoEditor`. Then, you can build the dockerfile in the cooked directory by doing a `docker build -t airsim-linux .`.

The run8 script lets you easily run 8 instances of the image, which is used by the reinforcement learning algorithm. 