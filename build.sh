#!/bin/bash

set -x
[[ -f Dockerfile ]] || echo "You need to run this script from the clone of the repository, ie the directory holding the Dockerfile"
docker build -t nanowallet .
if docker ps -a | grep nanowallet_build >/dev/null ; then
  docker start nanowallet_build
else
  docker run -d -it --name nanowallet_build nanowallet bash
fi
docker exec -it nanowallet_build bash -c "cd /NanoWallet && git checkout . && ( echo 'updating code' && git pull && npm install && sed -i -e \"s/'win64', 'osx64',//g\" -e '/\/\/ Uncomment/,/gulp.watch(j/d'  gulpfile.js && gulp && git checkout gulpfile.js ) "
[[ -d build ]] && mv build build.$(date +%Y%m%dT%H%M%S)
docker cp  nanowallet_build:/NanoWallet/build ./
docker stop nanowallet_build
echo "open file://$PWD/build/start.html in your browser"
