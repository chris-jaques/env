#!/bin/sh
#
# LWS Specific Helpers
#
#

# Install the LIFT CLI
i_lift_cli(){
    ghc llwebsol LIFT-CLI cli LIFT CLI
}

# Lift CLI
alias lcli='$(cli;pwd)/run.sh'

# Find a LIFT Client { clientName || clientID }
alias client='lcli find:client'

# Deploy Master LIFT Branch to Staging
alias deploymaster='pushd .;lift;mina deploy client=lift type=lift;popd'

# SSH Into Web1 Server
alias sshweb='ssh chris@web1.landlordwebsolutions.com'

# SSH Into DB Server
alias sshdb='ssh chris@db.landlordwebsolutions.com'