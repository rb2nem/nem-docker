#!/usr/bin/env bash
set -eu

#if [[ "$*" =~ nis || $# == 0 ]]; then
# we run the setup even if only ncc is run as the Dockerfile requires the
# nis config file to be present
  ./setup.sh
#fi

# we rebuild and remove existing container every time. 
# The benefits: upgrades are automatic after the git pull
sudo docker build -t mynem_image  .
sudo docker ps -a | grep mynem_container > /dev/null && sudo docker rm mynem_container
sudo docker run --name mynem_container -v ${PWD}/nem:/root/nem -t -d  -p 7890:7890 -p 8989:8989 mynem_image "$@"



if [[ "$*" =~ ncc || $# == 0 ]]; then
  echo "You can access the NEM Community Client at http://localhost:8989/"
fi
