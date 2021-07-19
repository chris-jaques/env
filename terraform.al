#!/bin/sh
#
# Terraform
#
#

# Terraform image from Docker Hub
export ENV_DOCKER_IMAGE_TERRAFORM="hashicorp/terraform:light"

# Terraform { ...commands }
alias tf='docker run --rm -it -v $HOME:/root -v $(pwd):/workspace -w /workspace $ENV_DOCKER_IMAGE_TERRAFORM'
