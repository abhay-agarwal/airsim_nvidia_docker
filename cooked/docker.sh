nvidia-docker run \
-e PORT \
-p 590$PORT:590$PORT \
-p 4145$PORT:41451 \
-v /tmp/.X11-unix:/tmp/.X11-unix \
--volume="/usr/lib/x86_64-linux-gnu/libXv.so.1:/usr/lib/x86_64-linux-gnu/libXv.so.1"
-it airsim-linux