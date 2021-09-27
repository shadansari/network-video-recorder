define PROJECT_HELP_MSG
Usage:
    make help                   show this message
    make clean                  remove intermediate files

    make ${VENV}                  make a virtualenv in the base directory
    make python-reqs            install python packages in requirements.pip
    make git-config             set local git configuration
    make setup                  make python-reqs

    make run                    launch network-video-recorder
    make run-native             run native application (no docker)
    make run-native-no-show     run native applicaiton (no docker) w/o video outpu
endef
export PROJECT_HELP_MSG

SHELL = /bin/bash
VENV = .venv
PYTHON = $(VENV)/bin/python3
PIP = $(VENV)/bin/pip
IMAGE = nvr

help:
	echo "$$PROJECT_HELP_MSG" | less

$(VENV)/bin/activate: requirements.txt
	python3 -m venv $(VENV)
	$(PIP) install -r requirements.txt

build:
	docker build -f docker/Dockerfile -t $(IMAGE) .

run:
	docker run -itu root:root --privileged --network host --name $(IMAGE) --rm $(IMAGE)

run-native-test:
	. ./network_video_recorder.sh -i ./resources/face-demographics-walking.mp4 

run-native:
	. ./network_video_recorder.sh -i gstreamer

run-native-test-no-show:
	. ./network_video_recorder.sh -i ./resources/face-demographics-walking.mp4 -ns

run-native-no-show:
	. ./network_video_recorder.sh -i gstreamer -ns

CLEANUP = *.pyc $(VENV)
clean:
	rm -rf ${CLEANUP}

.PHONY: run clean

