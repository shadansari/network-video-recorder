#python3 docker_openvino.py build -d cpu -os ubuntu18 --distribution runtime --product_version 2021.4
FROM ubuntu18_runtime:2021.4

USER root

RUN apt-get update && apt-get install -y \
   wget \
   unzip \
   libglib2.0-0 \
   libsm6 \
   libxrender1 \
   libxext6 \
   vim \
   ffmpeg \
   x11-apps

RUN apt-get install -y libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libgstreamer-plugins-bad1.0-dev gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-libav gstreamer1.0-doc gstreamer1.0-tools gstreamer1.0-x gstreamer1.0-alsa gstreamer1.0-gl gstreamer1.0-gtk3 gstreamer1.0-qt5 gstreamer1.0-pulseaudio

WORKDIR /var/network-video-recorder

COPY . .

RUN . .venv/bin/activate && \
     pip3 install -r requirements.txt

CMD . .venv/bin/activate && . /opt/intel/openvino/bin/setupvars.sh && python3 network_video_recorder/network_video_recorder.py -d CPU -i gstreamer -m resources/models/intel/person-detection-retail-0013/FP32/person-detection-retail-0013.xml -ns
