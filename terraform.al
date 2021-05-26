#!/bin/sh
#
# Terraform
#
#

# Terraform image from Docker Hub
export ENV_DOCKER_IMAGE_TERRAFORM="hashicorp/terraform:latest"

# Terraform { ...commands }
alias tf='docker run --rm -it -v $(pwd):/workspace -w /workspace $ENV_DOCKER_IMAGE_TERRAFORM'
