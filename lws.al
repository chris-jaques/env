#!/bin/bash
#
# LWS Specific Helpers
#
#

# Lift CLI
alias l='ruby ~/dev/lift-cli/bin/lift'

# Find a LIFT Client {clientName}
alias client='ruby ~/dev/lift-cli/bin/lift find:client'

# Deploy Master LIFT Branch to Staging
alias deploymaster='pushd .;lift;mina deploy client=lift type=lift;popd'

# SSH Into Web1 Server
alias sshweb='ssh chris@web1.landlordwebsolutions.com'

# SSH Into DB Server
alias sshdb='ssh chris@db.landlordwebsolutions.com'