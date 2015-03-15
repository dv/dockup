# Dockup

This is a collection of the scripts I'm using to set up my ideal docker environment.

There are two parts:

## `boot2docker`

Contains the scripts I use to start and stop `boot2docker` on Parallels using Vagrant to control the VM, and load in the required `DOCKER_HOST` environment variable.

## `skeleton`

Contains some nice default `Dockerfile` and `docker-compose.yml` to use when setting up a new Rails dev environment.

# Usage

## `boot2docker`

Source the script `up.sh` to load the vagrant image, and load the `DOCKER_HOST` variable. I attach it to an alias like so:

```
alias dockup="source ~/scripts/dockup/up.sh"
alias dockdown="~/scripts/dockup/down.sh"
```

You'll note that this will always use the same Vagrant box, no matter where you execute it. Since the Vagrant box is merely a host for the `docker` containers, I didn't want to create a new box for every app I'm running docker with, which saves on space.

Here's the output with the above `alias`es set:

```
$ dockup
Bringing machine 'default' up with 'parallels' provider...
==> default: Checking if box 'parallels/boot2docker' is up to date...
==> default: Forwarding ports...
    default: 2375 => 2375
==> default: Resuming suspended VM...
==> default: Waiting for machine to boot. This may take a few minutes...
    default: SSH address: 10.211.55.6:22
    default: SSH username: docker
    default: SSH auth method: private key
==> default: Machine booted and ready!
Client version: 1.5.0
Client API version: 1.17
Go version (client): go1.4.1
Git commit (client): a8a31ef
OS/Arch (client): darwin/amd64
Server version: 1.5.0
Server API version: 1.17
Go version (server): go1.4.1
Git commit (server): a8a31ef
```

```
$ dockdown
==> default: Clearing any previously set forwarded ports...
==> default: Saving VM state and suspending execution...
```



## History

Steps to get here

- Install vagrant
- Install boot2docker (optional?)
- Install docker (homebrew)
- Install vagrant-boot2docker https://github.com/Parallels/boot2docker-vagrant-box

```
$ vagrant plugin install vagrant-parallels
$ vagrant init parallels/boot2docker # In the path where dockup.sh lives
```

## skeleton

This is my standard go-to Rails development skeleton. It install the correct ruby version using the `.ruby-version` file (required).

The web docker image starts from the `phusion/baseimage` which is optimized for running daemons as well as a command. This to solve the problem where the web instance might require multiple daemons to run on the same container. An example is runnign Thinking Sphinx which requires a Rails instance running on the same host as Sphinx.


```
docker build .
docker-compose run
```

Every time Gemfile is changed, run docker build again which will install the correct gems.


# Sources

- [ruby-build wiki](https://github.com/sstephenson/ruby-build/wiki)
- [docker-compose rails](https://docs.docker.com/compose/rails/)
- [Rails development with Fig](http://www.whitesmith.co/blog/a-rails-development-environment-using-docker-through-fig/#choosingrubyversion)
- [Rails on docker (thoughtbot)](https://robots.thoughtbot.com/rails-on-docker)
- [boot2docker using parallels](http://standalonex.com/boot2docker-using-osx-parallel/)
- [boot2docker vagrant parallels box](https://github.com/Parallels/boot2docker-vagrant-box)
- [docker on osx the missing  guide](http://viget.com/extend/how-to-use-docker-on-os-x-the-missing-guide)