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