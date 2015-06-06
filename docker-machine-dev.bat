@echo off

REM create machine if not already exist, then start it
docker-machine create --driver="virtualbox" --virtualbox-memory="2048" dev
docker-machine start dev

REM set environment variables for this machine
docker-machine env dev | sed 's/export/set/g' > temp.cmd
sed -i 's/\"//g' temp.cmd
sed -i 's/#/REM/g' temp.cmd
call temp.cmd
del temp.cmd





REM
REM INDEPENDENT ALIASES
REM

REM alias drm-stop='docker rm $(docker ps -a -q)'
docker-machine ssh dev "echo \"alias drm-stop='docker rm \$(docker ps -a -q)'\" >> ~/.ashrc"

REM alias drmi-notag='docker rmi $(docker images -q --filter "dangling=true")'
docker-machine ssh dev "echo \"alias drmi-notag='docker rmi \$(docker images -q --filter \"dangling=true\")'\" >> ~/.ashrc"

REM alias install-docker-compose='docker build -t docker-compose github.com/docker/compose'
docker-machine ssh dev "echo \"alias install-docker-compose='docker build -t docker-compose github.com/docker/compose'\" >> ~/.ashrc"

REM alias docker-compose='docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock -v $(pwd):$(pwd) -w $(pwd) docker-compose'
docker-machine ssh dev "echo \"alias docker-compose='docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock -v \$(pwd):\$(pwd) -w \$(pwd) docker-compose'\" >> ~/.ashrc"

REM alias docker-compose-web='docker-compose run --service-ports web'
docker-machine ssh dev "echo \"alias docker-compose-web='docker-compose run --service-ports web'\" >> ~/.ashrc"





REM
REM PERSONAL ALIASES
REM

REM alias cd-compose='cd /c/Users/path/to/docker/compose/yml'
REM docker-machine ssh dev "echo \"alias cd-compose='cd /c/Users/path/to/docker/compose/yml'\" >> ~/.ashrc"





REM connect to the machine
docker-machine ssh dev
