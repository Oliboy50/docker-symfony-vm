Docker - Symfony VM
===
**Build a local Virtual Machine (Docker aware) which allows you to run a Symfony full stack application in Ubuntu container on any OS (including Windows/Mac)**


## Requirements

 - [msysgit](https://msysgit.github.io/) (for Windows user only, see ["Get a nice terminal" section below](#how-to))
 - [VirtualBox](https://www.virtualbox.org/wiki/Downloads) 
 - [Docker-machine](https://docs.docker.com/machine/#installation) (needs [version 0.3.0+](https://github.com/docker/machine/releases)) => just an executable to rename `docker-machine` and to move somewhere in your `PATH`


## What's inside?

### docker-machine-dev(.bat/.sh)
A simple yet powerful script that use Docker Machine to build a local Docker aware VM without even installing Docker. 
It's also used to set some useful aliases in the VM (such as`docker-compose` which run Docker Compose in a container).

### Dockerfile
 - Miscellaneous useful tools (`nano`, `vim`, `curl`, `wget`, etc.)
 - Nginx (including a default site configuration for Symfony app)
 - PHP 5.6 with FPM and Composer
 - Ruby and Python (could be needed to use some dependencies)
 - NodeJS 0.12 with `bower`, `gulp` and `grunt`

### docker-compose.yml
This file (using Docker-compose) will help you to build a perfect environment for your Symfony app by running and linking several containers the way you want using a single command. 
Keep in mind that this could also be done using many long `docker` commands without the need of `docker-compose` at all.


## How to use?

 1. _[Needed once]_ Clone this repository in a new folder at the root of your Symfony application sources (I'd suggest to name the folder `docker`)

 2. _[Needed once]_ Edit `docker-compose.yml` to fit your project needs

 3. Open a terminal then `cd` to the new folder and type `docker-machine-dev`. If everything worked, after a few seconds you will be given access to the VM where you will be able to run `docker` commands
 
 4. _[Needed once]_ Now you can "install" `docker-compose` with: 
`install-docker-compose`
 
 5. Then, again, `cd` to the new folder in your Symfony project (the VM shared your `C:\Users\` (windows) or `/Users/` (mac) folder as `/c/Users/` or `/Users/` --- see [complete reference here](https://github.com/boot2docker/boot2docker#virtualbox-guest-additions)) 
 
 6. Build and run the whole Symfony environment with:
`docker-compose-web` (which is an alias for `docker-compose run --service-ports web`)

 7. If everything worked you should be able to see your Symfony application running in your host browser at 192.168.99.100 (you can check if it is the correct IP by running `docker-machine ip dev` in your host terminal)


## Get a nice terminal and be able to use Git and many useful UNIX commands on Windows

 1. Install `msysgit` http://msysgit.github.io/ (bottom of the page)

 2. Install `Cmder` http://gooseberrycreative.com/cmder/ (mini version without msysgit)

 3. Add the following directories at the very beginning of the `PATH` environment variable (could be different if you chose a different installation path for msysgit): 
`C:\msysgit\bin;C:\msysgit\mingw\bin;C:\msysgit\cmd;`

 4. I'd also recommend to always run `Cmder` as an Administrator (right click => Properties, etc.). 

**ProTips**: One of the many nice things you can do with Cmder is setting persistent aliases such as `alias cd-docker=cd "C:\path\to\my\sf_project\docker"` =). To view and manage your aliases, edit the file located at `C:\cmder_installation_directory\config\aliases`.


## WTF!? You're using a Docker container as a VM!?
Indeed, I could have split this big image in many smaller images (i.e. PHP5.6 linked with PHP-FPM linked with NGINX linked with NodeJS linked with Ruby, etc.) but I just wanted to keep it really simple and independent from the host OS. 
This is meant to be a fast deployable development environment nothing else.
