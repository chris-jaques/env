#!/bin/sh
#
# LWS Specific Helpers
#
#

# Install the LIFT CLI
i_lift_cli(){
    ghc llwebsol lift-cli cli LIFT CLI
}

# Lift CLI
alias lcli='$(cli;pwd)/run.sh'

# Find a LIFT Client { searchTerm }
alias client='lfind client'

# Find a LIFT User { searchTerm }
alias user='lfind user'

# Find a LIFT Building { searchTerm }
alias building='lfind building'

# Find something with the lift cli { entity } { ...searchTerm? }
lfind(){
    entity=${1:?Missing parameter: entity}
    searchTerm=$2

    lcli find:$entity $searchTerm
}

# Deploy Master LIFT Branch to Staging
alias deploylift='lcli deploy lift'

# SSH Into Web1 Server
alias sshweb='ssh chris@web1.landlordwebsolutions.com'

# SSH Into DB Server
alias sshdb='ssh chris@db.landlordwebsolutions.com'

# SuperLIFT Invoice Breakdown { invoiceNumber }
inv(){
    invoiceNumber=${1:?Missing parameter: invoiceNumber}
    web "superlift.theliftsystem.com/invoices/breakdown/" "$invoiceNumber"
}