FROM ubuntu18_runtime:2021.4

USER root

RUN apt-get update && apt-get install -y \
   wget \
   unzip \
   libglib2.0-0 \
   libsm6 \
   libxrender1 \
   libxext6 \
   vim

WORKDIR /var/network-video-recorder

COPY . .

RUN . .venv/bin/activate && \
     pip3 install -r requirements.txt

CMD . .venv/bin/activate && . /opt/intel/openvino/bin/setupvars.sh && python3 network_video_recorder/network_video_recorder.py -d CPU -i ./resources/face-demographics-walking.mp4 ./resources/people-detection.mp4 -m resources/models/intel/person-detection-retail-0013/FP32/person-detection-retail-0013.xml
