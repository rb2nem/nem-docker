#!/bin/bash

docker build -t nanowallet .
docker run nanowallet tar -c -C /NanoWallet build | tar x
docker rmi nanowallet

echo "open file://$PWD/build/start.html in your browser"
