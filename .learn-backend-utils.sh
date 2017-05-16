#! /bin/bash

# Postgres Stuff
startPostgres () {
  echo 'Starting postgres...'
  brew services start postgres
  echo 'Done.'
}

restartPostgres() {
  echo 'Restarting postgres...'
  brew services restart postgres
  echo 'Done.'
}

stopPostgres () {
  echo 'Stopping postgres...'
  brew services stop postgres
  echo 'Done.'
}

# Learn GDL stuff
startLearn () {
  echo 'Starting learn server...'
  (cd $HOME/bb/learn; gdl startLearn)
  echo 'Done.'
}

stopLearn() {
  echo 'Stopping learn server...'
  (cd $HOME/bb/learn; gdl stopLearn)
  echo 'Done.'
}

startRouter() {
  echo 'Starting ultra-router...'
  (cd $HOME/bb/ultra-router; ./start)
  echo 'Done.'
}

# Bundle Utilities
startBackend () {
  startPostgres
  startLearn
}

stopBackend () {
  stopPostgres
  stopLearn
}

startUI () {
  echo 'Starting ultra-ui...'
  (cd $HOME/bb/ultra-ui; npm start)
  echo 'Done.'
}

# BB Git Stuff
updateRouter() {
  echo 'Updating ultra-router...'
  (cd $HOME/bb/ultra-router; git pull; gs)
  echo 'Done.'
}

updateLearn() {
  echo 'Updating learn...'
  (cd $HOME/bb/learn; git pull; gs)
  echo 'Done.'
}

updateLearnUtil() {
  echo 'Updating learn.util...'
  (cd $HOME/bb/learn.util; git pull; gs)
  echo 'Done.'
}

updateUI() {
  echo 'Updating ultra-ui...'
  (cd $HOME/bb/ultra-ui; ./update)
  echo 'Done.'
}

updateBackend() {
  echo 'Updating ultra-router, learn.util, and learn...'
  updateRouter
  updateLearnUtil
  updateLearn
  echo 'Done.'
}

nukeLearn() {
  echo 'Nuking Learn...'
  (cd $HOME/bb/learn;\
  stopLearn;\
  gdl clean;\
  gdl --stop;\
  find . -name .gradle | xargs rm -rf;\
  gdl installLearn;)
  echo 'Done.'
}
