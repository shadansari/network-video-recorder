#!/bin/bash
source .venv/bin/activate
source /opt/intel/openvino/bin/setupvars.sh
python3 network_video_recorder/network_video_recorder.py -d CPU -i ./resources/face-demographics-walking.mp4 -i2 ./resources/people-detection.mp4 -m ./resources/models/intel/person-detection-retail-0013/FP32/person-detection-retail-0013.xml
