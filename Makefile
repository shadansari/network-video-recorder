define PROJECT_HELP_MSG

Usage:
    make help			show this message
    make clean			remove intermediate files

    make ${VENV}			make a virtualenv in the base directory
    make python-reqs		install python packages in requirements.pip
    make git-config		set local git configuration
    make setup			make python-reqs

    make run			launch network-video-recorder

endef
export PROJECT_HELP_MSG

help:
	echo "$$PROJECT_HELP_MSG" | less

VENV = .venv
export VIRTUAL_ENV := $(abspath ${VENV})
export PATH := ${VIRTUAL_ENV}/bin:${PATH}

${VENV}:
	python3 -m venv $@

python-reqs: requirements.txt | ${VENV}
	. .venv/bin/activate; pip install --upgrade -r requirements.txt

setup: ${VENV} python-reqs

run:
	. .venv/bin/activate; source /opt/intel/openvino/bin/setupvars.sh; python3 network_video_recorder/network_video_recorder.py -d CPU -i ./resources/face-demographics-walking.mp4 -i2 ./resources/people-detection.mp4 -m ./resources/models/intel/person-detection-retail-0013/FP32/person-detection-retail-0013.xml

CLEANUP = *.pyc

clean:
	rm -rf ${CLEANUP}

PHONY: python-reqs setup
