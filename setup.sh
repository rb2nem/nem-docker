#!/usr/bin/env bash
set -eu
if [[ ! -f custom-configs/nis.config-user.properties ]] ; then
  echo -e "\e[31mNo config file was found. We need to generate one, even if you run only NCC\e[39m"
  echo -e "\e[32mEnter the name you want to assign to your node:\e[39m"
  read name
  echo -e "\e[34mEnter the boot key of your node. If you do not know what this is, press enter and one will be generated for you\e[39m"
  read key
  if [[ $key == "" ]] ; then
    key=$(< /dev/urandom tr -dc a-f0-9 | head -c64)
  fi
  cat >custom-configs/nis.config-user.properties <<EOF
nis.bootName = $name
nis.bootKey = $key
EOF

echo -e "\e[32mThe config file generated is at custom-configs/nis.config-user.properties\e[39m"

fi
