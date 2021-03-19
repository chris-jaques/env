#!/bin/sh
#
# Terraform
#
#

# Terraform { ...commands }
alias tf='docker run --rm -it -v $(pwd):/workspace -w /workspace hashicorp/terraform:full'
