#!/bin/sh
#
# Docker
#
#

# NodeJs image from Docker Hub
export ENV_DOCKER_IMAGE_NODE="node:latest"

# Dockerized npm. Run npm on the current directory, from within a Docker container { ...command }
dnpm(){
	if ! [ -f ~/.npmrc ]; then
		touch ~/.npmrc
	fi
	docker run --rm -it -v $(pwd):/npm -w /npm -u $(id -u) -v ~/.npmrc:/home/node/.npmrc $ENV_DOCKER_IMAGE_NODE npm "${@:1}"
}