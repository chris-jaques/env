#!/bin/sh
#
# kubernetes
#
#

# Install kubectl
i_kubectl(){
    gcloud components install kubectl
}

# kubectl
alias k="kubectl"

# kubectl get
alias kg="kubectl get"