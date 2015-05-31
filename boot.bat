@echo off

boot2docker start

REM alias drm-stop='docker rm $(docker ps -a -q)'
set drmstop="echo \"alias drm-stop='docker rm \$(docker ps -a -q)'\" >> ~/.ashrc"
boot2docker ssh %drmstop%

REM alias drmi-notag='docker rmi $(docker images -q --filter "dangling=true")'
set drminotag="echo \"alias drmi-notag='docker rmi \$(docker images -q --filter \"dangling=true\")'\" >> ~/.ashrc"
boot2docker ssh %drminotag%

REM alias install-docker-compose='docker build -t docker-compose github.com/docker/compose'
set installdockercompose="echo \"alias install-docker-compose='docker build -t docker-compose github.com/docker/compose'\" >> ~/.ashrc"
boot2docker ssh %installdockercompose%

REM alias cd-compose='cd /c/Users/path/to/docker/compose/yml'
set cdtocompose="echo \"alias cd-compose='cd /c/Users/path/to/docker/compose/yml'\" >> ~/.ashrc"
boot2docker ssh %cdtocompose%

REM alias dcompose='docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock -v $(pwd):$(pwd) -w $(pwd) docker-compose'
set dcompose="echo \"alias dcompose='docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock -v \$(pwd):\$(pwd) -w \$(pwd) docker-compose'\" >> ~/.ashrc"
boot2docker ssh %dcompose%

REM alias dcompose-myapp='dcompose run --service-ports myapp'
set dcomposemyapp="echo \"alias dcompose-myapp='dcompose run --service-ports myapp'\" >> ~/.ashrc"
boot2docker ssh %dcomposemyapp%

boot2docker ssh
