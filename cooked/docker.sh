docker kill airsim-0$PORT
docker rm airsim-0$PORT
nvidia-docker run --name airsim-0$PORT --restart=on-failure -e PORT -p 590$PORT:590$PORT -p 4145$PORT:41451 -v /tmp/.X11-unix:/tmp/.X11-unix --volume="/usr/lib/x86_64-linux-gnu/libXv.so.1:/usr/lib/x86_64-linux-gnu/libXv.so.1" -it airsim-linux