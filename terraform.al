#!/bin/sh
#
# Terraform
#
#

# Terraform image from Docker Hub
export ENV_DOCKER_IMAGE_TERRAFORM="hashicorp/terraform:light"

# Terraform { ...commands }
alias tf='docker run --rm -it -v $HOME:/root -v $(pwd):/workspace -w /workspace $ENV_DOCKER_IMAGE_TERRAFORM'

# Terraform with .env file passed into container { env_file } { ...commands }
tfe(){
    env_file=${1:-Missing parameter: env_file}
    docker run --rm -it -v $HOME:/root -v $(pwd):/workspace -w /workspace --env-file=${env_file} $ENV_DOCKER_IMAGE_TERRAFORM ${@:2}
}

# Format Terraform
alias tff='tf fmt -recursive;'