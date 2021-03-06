#! /bin/bash

alias d='docker'
alias dc='docker-compose'
alias dm='docker-machine'

alias dn='docker network'
alias di='docker image'
alias dv='docker volume'
alias dct='docker container'

alias de='docker exec -it'

export DOCKER_ID_USER="mtheoryx"

# Portainer start and stop utilities

## Start up portainer
function portUp () {
  (cd ~/code/platform/portainer; )
}

## Shut down portainer, completely
function portDown () {
  (cd ~/code/platform/portainer; )
}

