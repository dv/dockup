#!/bin/zsh
pushd `dirname $0` > /dev/null

vagrant up --provider parallels && \
export DOCKER_HOST="tcp://`vagrant ssh-config | sed -n "s/[ ]*HostName[ ]*//gp"`:2375" && \
docker version

popd
