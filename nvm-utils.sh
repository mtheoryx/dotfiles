#! /bin/bash
# NVM Stuff

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

[[ -r $NVM_DIR/bash_completion ]] && . $NVM_DIR/bash_completion

# Setup stuff we like in new nvm/node/npm environment

migratenode () {
  echo 'Starting node package migration...'
  (cd ~; npm install yarn; npm install create-react-app)
  echo 'Done migrating desired node packages.'
}