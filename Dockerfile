FROM nvidia/cuda:8.0-devel-ubuntu16.04

ENV TZ='Etc/UTC'
RUN apt-get update \
	&& apt-get install -y git unzip build-essential cmake wget sudo software-properties-common tzdata libnss3 libpangocairo-1.0-0 libgconf-2-4 libxi-dev libxcursor-dev libxss-dev libxcomposite-dev libxdamage-dev libasound-dev libatk1.0-dev libxrandr-dev libxtst-dev libopenal-dev libglu1-mesa-dev mesa-utils \
	&& wget -O - http://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - \
	&& apt-add-repository "deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-3.9 main" \
	&& apt-get update \
	&& apt-get install -y --allow-unauthenticated clang-3.9 \
	&& update-alternatives --install /usr/bin/clang clang /usr/bin/clang-3.9 60 --slave /usr/bin/clang++ clang++ /usr/bin/clang++-3.9 \
	&& rm -rf /var/lib/apt/lists/*
COPY virtualgl_2.5.2_amd64.deb .
RUN dpkg -i virtualgl_2.5.2_amd64.deb \
	&& /opt/VirtualGL/bin/vglserver_config -config +s +f -t
LABEL com.nvidia.volumes.needed="nvidia_driver"
ENV PATH /usr/local/nvidia/bin:/opt/VirtualGL/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64:${LD_LIBRARY_PATH}

RUN useradd -m unreal && echo "unreal:unreal" | chpasswd && adduser unreal sudo
USER unreal
WORKDIR /home/unreal

RUN git clone https://github.com/Microsoft/AirSim.git && cd AirSim/cmake && sudo bash ./getlibcxx.sh; exit 0
COPY airsim.patch .
COPY airsim2.patch .
RUN cd AirSim/MavLinkCom/include && patch -p0 < ~/airsim2.patch
RUN cd AirSim && patch -p0 < ~/airsim.patch && ./build.sh
RUN cd AirSim && rsync -t -r Unreal/Plugins Unreal/Environments/Blocks
ENV EIGEN_ROOT /home/unreal/AirSim/eigen

ADD UnrealEngine-4.15.0-release.zip /home/unreal/
COPY ltc4.patch .
RUN cd UnrealEngine-4.15.0-release/Engine/Source/Programs/UnrealBuildTool/Linux && patch -p0 < ltc4.patch
RUN cd UnrealEngine-4.15.0-release && ./Setup.sh && ./GenerateProjectFiles.sh -project="/home/unreal/AirSim/Unreal/Environments/Blocks/Blocks.uproject" -game -engine


RUN mkdir -p out && cd AirSim/Unreal/Environments/Blocks && ~/UnrealEngine-4.15.0-release/Engine/Build/BatchFiles/RunUAT.sh BuildCookRun -project="$PWD/Blocks.uproject" -platform=Linux -clientconfig=Shipping -cook -allmaps -build -stage -pak -archive -archivedirectory="/home/unreal/out"
