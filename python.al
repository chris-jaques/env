#!/bin/sh
#
# Python
#
#

# Python image from Docker Hub
export ENV_DOCKER_IMAGE_PYTHON="python:3.7-alpine"

# Dockerized Python
dpy(){
    docker run --rm -it -v $PWD:$PWD -w $PWD $ENV_DOCKER_IMAGE_PYTHON python ${@:1}
}

# Run Unit Tests { ...testFiles? }
pytest(){ 
    python -m unittest ${@:1}
}

# Run Integration Tests { ...testFiles? }
pyinttest(){ 
    python -m unittest discover -p *int_test.py ${@:1}
}

# Run End to End Tests { ...testFiles? }
pye2etest(){ 
    python -m unittest discover --failfast -p *e2e_test.py ${@:1}
}
