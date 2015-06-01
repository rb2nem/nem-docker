#!/usr/bin/env bash
set -eu

./setup.sh

sudo docker build -t mynis  .
sudo docker run --name mynis -v ${PWD}/nem:/root/nem -t -d  -p 7890:7890 mynis
