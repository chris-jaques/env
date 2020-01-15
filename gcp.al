#!/bin/sh
# 
# GCP
#

# Install the GCP SDK
i_gcp(){
    pushd .
    cd ~/Downloads

    # https://cloud.google.com/sdk/docs/downloads-versioned-archives
    wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-258.0.0-linux-x86_64.tar.gz
    tar -zxvf google-cloud-sdk-258.0.0-linux-x86_64.tar.gz

    ./google-cloud-sdk/install.sh
    ./google-cloud-sdk/bin/gcloud init

    popd
}

# Get the current gcloud project
ggproject(){ 
    gcloud config get-value project
}

# Setup gcloud dev creds    
ggdev(){
  export GOOGLE_CLOUD_PROJECT=`ggproject`
  export GOOGLE_APPLICATION_CREDENTIALS=$PWD/secret.json
  export GOOGLE_APPLICATION_CREDENTIALS_DKC=/secret.json
  export GOOGLE_APPLICATION_CREDENTIALS_DK=/`basename $PWD`/secret.json
  export GOOGLE_PROJECT=`ggproject`
}
