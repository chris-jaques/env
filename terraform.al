#!/bin/sh
#
# Terraform
#
#

# Terraform { ...commands }
alias tf='dri -v $(pwd):/workspace -w /workspace hashicorp/terraform:full'
