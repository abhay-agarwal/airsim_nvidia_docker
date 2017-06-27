#!/bin/bash
set -e
if [ ! -d "LinuxNoEditor" ] ; then
    echo "You have not built and run the docker from the build script. Exiting"
    exit 1
fi

docker build -t airsim-linux .
for PORT in 2 3 4 5 6 7 8 9; do
	 docker kill -t 0 airsim-0$PORT > /dev/null || :
	 docker rm airsim-0$PORT > /dev/null || :
    PORT=$PORT sh docker.sh
done
docker ps
