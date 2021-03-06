Docker - Symfony VM
===

:warning: This repo will be deprecated as soon as [Docker for Mac/Windows](https://blog.docker.com/2016/03/docker-for-mac-windows-beta/) will be officially released.

**Build a local Virtual Machine (Docker aware) which allows you to run a Symfony full stack application in Ubuntu container on any OS (including Windows/Mac)**


## Requirements

 - [msysgit](https://git-for-windows.github.io/) **for Windows user only** (see ["Get a nice terminal"](#get-a-nice-terminal-and-use-git-and-many-useful-unix-commands-on-windows) section below if you don't know how to do)
 - [VirtualBox](https://www.virtualbox.org/wiki/Downloads) 
 - [Docker Machine](https://github.com/docker/machine/releases) => `docker-machine(.exe)` (and `docker-machine-driver-virtualbox(.exe)` since 0.5.0) to move somewhere in your `PATH`


## What's inside?

### docker-machine-dev(.bat/.sh)
A really simple script which uses Docker Machine to build a local Docker aware VM without even installing Docker. 
It's also used to set some useful aliases such as `drm-all` (which remove all exited containers), `drmi-notag` (which remove all untagged images) and `docker-compose` (which run Docker Compose in a container), so go check this script and be free to set your own aliases there.

### Dockerfile
 - Miscellaneous useful packages (`make`, `vim`, `nano`, `curl`, `wget`, `git`, `python-software-properties` and `software-properties-common` to be able to add PPA)
 - Nginx with a default site configuration for Symfony app (including HTTPS support)
 - PHP 5.6 with FPM and Composer (including php.ini file which is used by both FPM and CLI)
 - Ruby 2.2.3 with `bundler`, `sass`, `less` and `capistrano`
 - NodeJS 4.x with `nodemon`, `pm2`, `bower`, `gulp` and `grunt`

### docker-compose.yml
This file (using Docker Compose) will help you to build a perfect environment for your Symfony app by running and linking several containers the way you want using a single command. 
Keep in mind that this could also be done using many long `docker` commands without the need of `docker-compose` at all.


## How to use?

### First time

 1. Clone this repository in a new folder (let's name it `docker`) **at the root of your Symfony application sources**, with:
`git clone https://github.com/Oliboy50/docker-symfony-vm.git docker`

 2. Go to the new folder `cd docker` and launch `docker-machine-dev` script.
After a few seconds you will be given access to the VM where you will be able to run `docker` commands

 3. Now that you are in your VM, you can "install" `docker-compose` with: 
`install-docker-compose`
 
 4. Then, again, `cd` to the new folder in your Symfony project (the VM shared your `C:\Users\` (windows) or `/Users/` (mac) folder as `/c/Users/` or `/Users/` --- see [complete reference here](https://github.com/boot2docker/boot2docker#virtualbox-guest-additions)) 
 
 5. Build and run the whole Symfony environment with:
`docker-compose-web` 
(this is just an alias for `docker-compose run --service-ports web`)

 6. If everything worked you should be able to see your Symfony application running in your host browser at 192.168.99.100 (you can check if it is the correct IP by running `docker-machine ip dev` in your host terminal)

When you want to stop coding, `exit` your VM then stop it with `docker-machine stop dev`.

### Second time and more

    # Host terminal
    cd C:\Users\mySymfonyApp\docker
    docker-machine-dev
    # VM terminal
    cd /c/Users/mySymfonyApp/docker
    docker-compose-web


## Get a nice terminal and use Git and many useful UNIX commands on Windows

 1. Install `Cmder` http://cmder.net/ (full version with msysgit)

 2. Configure it to always be ran as an Administrator (right click => Properties, etc.)
 
 3. You may have to define its default terminal type as `{cmd}` instead of `{PowerShell}` (because you may experience issues if you use `{PowerShell}` terminal)

**ProTips**: 

- You can set persistent aliases such as `alias cd-project=cd "C:\Users\mySymfonyApp\docker"` =). To view and manage your aliases, edit the file located at `C:\cmder_installation_directory\config\aliases`.

- You can dump executable files (such as `docker-machine.exe`) in `C:\cmder_installation_directory\bin` then those executables will be automatically accessible in your terminal (i.e. `docker-machine`).


## Troubleshooting

### `npm install` fails in my project
This issue comes from your application shared folders, `vboxsf` seems to be not powerful enough to handle so many files.
There are currently 2 workarounds for this kind of issue:

- (Recommended) In your application container, copy the `package.json` file to another (not shared) directory. Run `npm install` there. Then copy back the `node_modules` directory to the root of you application.

or

- Run `npm install` on your host machine (it requires you to have `npm` already installed on your host of course). 

### Starting VM hanging / VirtualBox warning when running `docker-machine-dev`
This issue comes from the 5.x versions of VirtualBox.
First, try to update VirtualBox (I don't have this issue on Windows 10 / Docker Machine 0.5.0 / VirtualBox 5.0.10).
If you still have this issue with the latest VirtualBox, there are currently 2 workarounds:

- (Recommended) Each time you run `docker-machine-dev`, you'll have to close the VirtualBox warning window.

or

- Installed the last 4.x version of VirtualBox. (I used VirtualBox 4.3.26 when I used Windows 8.1 with Docker Machine 0.3.0)
