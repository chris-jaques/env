#!/bin/sh
# 
# GCP
#

# Terraform image from Docker Hub
export ENV_DOCKER_IMAGE_GCLOUD="gcr.io/google.com/cloudsdktool/cloud-sdk:alpine"

# Dockerized gcloud cli
gg(){
  docker run --rm -it \
    -v $(pwd):/w \
    -v ${HOME}/.config:/root/.config \
    -w /w \
    -e GOOGLE_CLOUD_PROJECT=${GOOGLE_CLOUD_PROJECT} \
    -e GOOGLE_APPLICATION_CREDENTIALS=${GOOGLE_APPLICATION_CREDENTIALS} \
    -e GOOGLE_APPLICATION_CREDENTIALS_DKC=${GOOGLE_APPLICATION_CREDENTIALS_DKC} \
    -e GOOGLE_APPLICATION_CREDENTIALS_DK=${GOOGLE_APPLICATION_CREDENTIALS_DK} \
    -e GOOGLE_PROJECT=${GOOGLE_PROJECT} \
    ${ENV_DOCKER_IMAGE_GCLOUD} \
    gcloud ${@:1}
}

# Get the current gcloud project
ggproject(){ 
    gg config get-value project
}

# Setup gcloud dev creds { keyfile=secret.json }
ggdev(){
  export GOOGLE_CLOUD_PROJECT=`ggproject`
  export GOOGLE_APPLICATION_CREDENTIALS=$PWD/secret.json
  export GOOGLE_APPLICATION_CREDENTIALS_DKC=/secret.json
  export GOOGLE_APPLICATION_CREDENTIALS_DK=/`basename $PWD`/secret.json
  export GOOGLE_PROJECT=`ggproject`
}
