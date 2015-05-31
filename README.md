Docker - Symfony / Nginx
===
**Allows you to run Symfony full stack application in Linux container while developing from any OS (including Windows)**


## What's inside?

### Dockerfile
**Read The Fucking `Dockerfile`** (it's easy, I promise)

#### TL;DR
 - Miscellaneous useful tools (`nano`, `vim`, `curl`, `wget`, etc.)
 - Nginx (including a default site configuration for Symfony app)
 - PHP 5.6 with FPM and Composer
 - Ruby and Python (could be needed to use some dependencies)
 - NodeJS 0.12 with `bower`, `gulp` and `grunt`

### docker-compose.yml
This file (using Docker-compose) will help you to build a perfect environment for your Symfony app by running and linking several containers the way you want with a single command. Keep in mind that, this could also be done using many long and boring `docker` commands without the need of `docker-compose` at all... but it's a lot better to maintain a YAML file and just type `docker-compose run --service-ports myapp`

### boot.bat (Windows users only)
A simple user personal script which set some Docker related useful aliases before starting boot2docker. This kind of script is a must have for all Windows users, because it greatly eases the use of Docker and Docker-compose.


## How to use?

### Windows

 1. Clone this repository at the root of your application sources (feel free to rename the repository folder).

 2. Edit `docker-compose.yml` the way you want (you might don't need a MySQL database, or you just want to replace `myapp` with the name of your application).

 3. Edit `boot.bat` to fit your personal environment (typically, you will want to set a correct path for the `cd-compose` alias and adjust `dcompose-myapp` alias according to your `docker-compose.yml` file if you edited it).

 4. Open a Windows terminal (I recommend to use [Cmder](http://gooseberrycreative.com/cmder/) instead of the default one), then `cd` to the `boot.bat` file and type the 3 following commands:
 `boot`
 `cd-compose`
 `dcompose-myapp` (you may need to type `install-docker-compose` before, if you haven't already a `docker-compose` image available)


## Need more?
Feel free to extend this image or just edit the `docker-compose.yml` file to let other containers join the party.
The only thing to keep in mind is that it would be best if your whole team use the same image.


## Never used Docker or Docker-compose before?

### Docker on Windows

#### Get a nice terminal and be able to use Git and many useful UNIX commands _(Optional but strongly recommended)_

 1. Install `msysgit` http://msysgit.github.io/ (bottom of the page)

 2. Install `Cmder` http://gooseberrycreative.com/cmder/ (mini version without msysgit)

 3. Add the following directories at the very beginning of the PATH environment variable (could be different if you chose a different installation path for msysgit and Cmder): 
`C:\cmder\bin;C:\msysgit\bin;C:\msysgit\mingw\bin;C:\msysgit\cmd;`

 4. From now on, when I will talk about **Windows terminal**, you will understand **Cmder terminal opened as Administrator**. You can test your new Windows terminal to handle carriage return for Git on Windows:
`git config --global core.autocrlf true`

#### Install Docker

 1. Install `Boot2Docker` http://docs.docker.com/installation/windows/ (during installation, uncheck `msysgit` if you followed the previous step)

 2. Initialize Boot2Docker and update the Virtual Machine with the following commands:
`boot2docker init`
`boot2docker stop`
`boot2docker download`

#### Use `docker` (have a working Docker client)

 1. To start the VM (including the Docker daemon):
`boot2docker start`

 2. To access the VM through SSH:
`boot2docker ssh`

 3. _(Optional)_ You will notice a warning message about missing environment variables and how to set them using `export`, if you aim to fix this, you will have to enter these commands in your Windows terminal but `export` won't work so you will have to replace `export` commands with `set` commands in order to fix this. Anyway, keep in mind that this is optional (AFAIK) because it will only allow you to use Docker directly in your Windows terminal instead of having to access the VM through SSH.

#### Install Docker-compose

 1. The easiest way to use `docker-compose` on Windows is to run it on it's own container. So first, you will need to build your own image of docker-compose:
`docker build -t docker-compose github.com/docker/compose`

 
#### Use `docker-compose` to build our Symfony environment

 1. Now that you have your `docker-compose` image set, each time you will want to use a simple `docker-compose` command, you will have to type instead:
`docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock -v $(pwd):$(pwd) -w $(pwd) docker-compose`

 So it might be a good idea to set an `alias` for this, I chose the name `dcompose`:
`alias dcompose='docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock -v $(pwd):$(pwd) -w $(pwd) docker-compose'`

 2. Go to your `docker-compose.yml` file path (keep in mind that `boot2docker` share your Windows directory `C:\\Users` with the VM as `/c/Users`):
 `cd /c/Users/path/to/my/docker/compose/yml/file`
 
 3. Try to run `myapp` with `docker-compose`:
 `dcompose run --service-ports myapp`
 
 4. After you played a bit with this, you will want **Protips**. Go to **How to use?** main section to really enjoy Docker on Windows.
 
