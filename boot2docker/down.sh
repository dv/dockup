#!/bin/zsh
pushd `dirname $0` > /dev/null

vagrant suspend

popd
