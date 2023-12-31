ARG PYTHON_VERSION=3.10

FROM python:${PYTHON_VERSION}
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -qq && \
    apt-get install -y \
      curl libopencv-dev lsof git sudo tmux tree vim wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/apk/*

ENV WORK_PATH /workspace
WORKDIR $WORK_PATH
ENV PYTHONPATH "/workspace:${PYTHONPATH}"
ENV PIP_OPTIONS "--no-cache-dir --progress-bar off"
COPY requirements.txt $WORK_PATH/docker
RUN pip install --upgrade pip && \
    pip install ${PIP_OPTIONS} -r $WORK_PATH/docker/requirements.txt && \
    pip install ${PIP_OPTIONS} -U setuptools

# duser setting
ARG USER_ID
ARG GROUP_ID
RUN addgroup --gid $GROUP_ID duser && \
    adduser --disabled-password --gecos '' --uid ${USER_ID} --gid ${GROUP_ID} duser && \
    adduser duser sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER duser
