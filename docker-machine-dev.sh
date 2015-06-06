#!/bin/bash
set -e

# create machine if not already exist, then start it
docker-machine create --driver="virtualbox" dev
docker-machine start dev

# set environment variables for this machine
eval "$(docker-machine env dev)"





#
# INDEPENDENT ALIASES
#

# alias drm-stop='docker rm $(docker ps -a -q)'
docker-machine ssh dev "echo \"alias drm-stop='docker rm \$(docker ps -a -q)'\" >> ~/.ashrc"

# alias drmi-notag='docker rmi $(docker images -q --filter "dangling=true")'
docker-machine ssh dev "echo \"alias drmi-notag='docker rmi \$(docker images -q --filter \"dangling=true\")'\" >> ~/.ashrc"

# alias install-docker-compose='docker build -t docker-compose github.com/docker/compose'
docker-machine ssh dev "echo \"alias install-docker-compose='docker build -t docker-compose github.com/docker/compose'\" >> ~/.ashrc"

# alias docker-compose='docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock -v $(pwd):$(pwd) -w $(pwd) docker-compose'
docker-machine ssh dev "echo \"alias docker-compose='docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock -v \$(pwd):\$(pwd) -w \$(pwd) docker-compose'\" >> ~/.ashrc"

# alias docker-compose-web='docker-compose run --service-ports web'
docker-machine ssh dev "echo \"alias docker-compose-web='docker-compose run --service-ports web'\" >> ~/.ashrc"





#
# PERSONAL ALIASES
#

# alias cd-compose='cd /c/Users/path/to/docker/compose/yml'
# docker-machine ssh dev "echo \"alias cd-compose='cd /c/Users/path/to/docker/compose/yml'\" >> ~/.ashrc"





# connect to the machine
docker-machine ssh dev
