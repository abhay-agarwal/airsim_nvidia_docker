FROM nvidia/cuda:8.0-devel-ubuntu16.04

COPY virtualgl_2.5.2_amd64.deb .
RUN dpkg -i virtualgl_2.5.2_amd64.deb \
        && /opt/VirtualGL/bin/vglserver_config -config +s +f -t \
        && apt-get update && apt-get install -y sudo wget mesa-utils \
                libnss3 libpangocairo-1.0-0 libgconf-2-4 libxi-dev \
                libxcursor-dev libxss-dev libxcomposite-dev libasound-dev \
                libatk1.0-dev libxrandr-dev libxtst-dev libopenal-dev \
        && rm -rf /var/lib/apt/lists/*
LABEL com.nvidia.volumes.needed="nvidia_driver"
ENV PATH /usr/local/nvidia/bin:/opt/VirtualGL/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64:${LD_LIBRARY_PATH}

RUN useradd -m unreal && echo "unreal:unreal" | chpasswd && adduser unreal sudo && echo "unreal ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
USER unreal
WORKDIR /home/unreal

COPY keyboard /etc/default/
COPY tigervncserver_1.8.0-1ubuntu1_amd64.deb .
RUN sudo apt-get update && sudo dpkg -i tigervncserver_1.8.0-1ubuntu1_amd64.deb; sudo apt-get -f -y install && sudo apt-get install -y xserver-xorg && sudo rm -rf /var/lib/apt/lists/* && sudo rm tigervncserver_1.8.0-1ubuntu1_amd64.deb

COPY LinuxNoEditor .
COPY settings.json /home/unreal/Documents/AirSim/

COPY launch.sh .
CMD bash ./launch.sh
