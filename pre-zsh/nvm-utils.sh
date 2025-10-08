#! /bin/bash
# NVM Stuff

export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"

[[ -r $NVM_DIR/bash_completion ]] && . $NVM_DIR/bash_completion

# Setup stuff we like in new nvm/node/npm environment

# migratenode () {
#   echo 'Starting node package migration...'
#   (cd ~; npm install yarn; npm install create-react-app)
#   echo 'Done migrating desired node packages.'
# }