@echo off

boot2docker start

REM alias drm-stop='docker rm $(docker ps -a -q)'
set drmstop="echo \"alias drm-stop='docker rm \$(docker ps -a -q)'\" >> ~/.ashrc"
boot2docker ssh %drmstop%

REM alias drmi-notag='docker rmi $(docker images -q --filter "dangling=true")'
set drminotag="echo \"alias drmi-notag='docker rmi \$(docker images -q --filter \"dangling=true\")'\" >> ~/.ashrc"
boot2docker ssh %drminotag%

REM alias dcompose='docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock -v $(pwd):$(pwd) -w $(pwd) docker-compose'
set dcompose="echo \"alias dcompose='docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock -v \$(pwd):\$(pwd) -w \$(pwd) docker-compose'\" >> ~/.ashrc"
boot2docker ssh %dcompose%

REM alias dcompose-sir='dcompose run --service-ports sir'
set dcomposesir="echo \"alias dcompose-sir='dcompose run --service-ports sir'\" >> ~/.ashrc"
boot2docker ssh %dcomposesir%

REM alias drun-mysql='docker run -d --name mysql -it -p 3306:3306 -e MYSQL_ALLOW_EMPTY_PASSWORD=yes -e MYSQL_DATABASE=sir mysql'
set drunmysql="echo \"alias drun-mysql='docker run -d --name mysql -it -p 3306:3306 -e MYSQL_ALLOW_EMPTY_PASSWORD=yes -e MYSQL_DATABASE=sir mysql'\" >> ~/.ashrc"
boot2docker ssh %drunmysql%

REM alias drun-sir='docker run --rm --name sir -it -p 80:80 -v /c/Users/Oliver/Desktop/projets_perso/link-value:/var/www/html --link mysql:mysql oliboy50/sir'
set drunsir="echo \"alias drun-sir='docker run --rm --name sir -it -p 80:80 -v /c/Users/Oliver/Desktop/projets_perso/link-value:/var/www/html --link mysql:mysql oliboy50/sir'\" >> ~/.ashrc"
boot2docker ssh %drunsir%

REM alias cd-sir='cd /c/Users/Oliver/Desktop/projets_perso/link-value/docker-sir'
set cdsir="echo \"alias cd-sir='cd /c/Users/Oliver/Desktop/projets_perso/link-value/docker-sir'\" >> ~/.ashrc"
boot2docker ssh %cdsir%

boot2docker ssh
