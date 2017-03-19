#!/bin/bash

set -x
[[ -f Dockerfile ]] || echo "You need to run this script from the clone of the repository, ie the directory holding the Dockerfile"
docker build -t nanowallet .
if docker ps -a | grep nanowallet_build >/dev/null ; then
  docker start nanowallet_build
else
  docker run -d -it --name nanowallet_build nanowallet bash
fi
docker exec -it nanowallet_build bash -c "cd /NanoWallet && [[ \"$(git rev-parse @{u})\" == \"$(git rev-parse @)\" ]] || ( echo 'updating code' && git pull && npm install && sed -i -e '/browserSync.init/,+7d' gulpfile.js && gulp build-app && checkout gulpfile.js ) "
docker cp  nanowallet_build:/NanoWallet/build ./
docker stop nanowallet_build
echo "open file://$PWD/build/start.html in your browser"
