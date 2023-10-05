PROJECT_NAME=template
CONTAINER_NAME=${USER}_${PROJECT_NAME}
PORT=8885
SHM_SIZE=2g
FORCE_RM=true

build_python_linux:
	docker build \
		--build-arg USER_ID=$(shell id -u) \
		--build-arg GROUP_ID=$(shell id -g) \
		-f docker/Dockerfile \
		-t unilab_train_python \
		--force-rm=${FORCE_RM}\
		.

restart: stop run



run_python:
	docker run \
		-dit \
		-v $(PWD):/workspace \
		-p 8883:8883 \
		--name unilab_train_python \
		--rm \
		--shm-size $(SHM_SIZE) \
		unilab_train_python




exec_python:
	docker exec \
		-it \
		unilab_train_python bash

stop:
	docker stop unilab_train_python
run_jupyter:
	jupyter nbextension enable --py widgetsnbextension
	jupyter notebook --ip=0.0.0.0 --port ${PORT} --allow-root