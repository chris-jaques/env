#!/bin/sh
#
# LWS Specific Helpers
#
#

# Install the LIFT CLI
i_lift_cli(){
    ghc llwebsol LIFT-CLI cli LIFT CLI
}

# Build the LIFT CLI
alias lclibuild='$(cli;pwd)/build.sh'

# Lift CLI
alias lcli='$(cli;pwd)/run.sh'

# Find a LIFT Client { clientName || clientID }
alias client='lcli find:client'

# Deploy Master LIFT Branch to Staging
alias deploymaster='lcli deploy lift'

# SSH Into Web1 Server
alias sshweb='ssh chris@web1.landlordwebsolutions.com'

# SSH Into DB Server
alias sshdb='ssh chris@db.landlordwebsolutions.com'