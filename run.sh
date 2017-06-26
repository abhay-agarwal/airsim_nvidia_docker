set -e
set -x
docker build -t airsim-unreal-builder . 
sudo rm -rf ./cooked/LinuxNoEditor
docker run -v $(pwd):/ext airsim-unreal-builder cp -r /home/unreal/out/LinuxNoEditor /ext/cooked/
