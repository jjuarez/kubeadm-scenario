#!/bin/bash

declare -r DOCKER_VERSION_CERTIFIED="17.03.2"

curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
add-apt-repository \
"deb [arch=amd64] https://download.docker.com/linux/debian/
$(lsb_release -cs)
stable"

apt-get update &&
apt-get install -qy docker-ce="${DOCKER_VERSION_CERTIFIED}~ce-0~debian-stretch"
