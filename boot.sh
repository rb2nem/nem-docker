#!/usr/bin/env bash
set -eu

#if [[ "$*" =~ nis || $# == 0 ]]; then
# we run the setup even if only ncc is run as the Dockerfile requires the
# nis config file to be present
  ./setup.sh
#fi

# we rebuild and remove existing container every time. 
# The benefits: upgrades are automatic after the git pull
docker build --rm=false -t mynem_image  .
docker ps -a | grep mynem_container > /dev/null && docker rm mynem_container
docker run --restart always --name mynem_container -v ${PWD}/nem:/root/nem -t -d  -p 7890:7890 -p 8989:8989 mynem_image



if [[ "$*" =~ nis || $# == 0 ]]; then
  echo "Starting NIS"
  ./supervisorctl.sh start nis
fi

if [[ "$*" =~ ncc ]]; then
  echo -e "\e[32mStarting NCC, which will be available at http://localhost:8989\e[39m"
  ./supervisorctl.sh start ncc
fi

echo "All done, here are the services running:"
echo -e "\e[34m"
./supervisorctl.sh status
echo -e "\e[39m"
echo
echo -e "\e[32m--------------------------------------------------------------------------------"
echo "You can control both services named 'ncc' and 'nis' with the script ./service.sh"
echo "run ./service.sh without argument to get help"
echo
echo "You can access the supervisord control shell with ./supervisorctl.sh"
echo -e "--------------------------------------------------------------------------------\e[39m"
