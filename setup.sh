#!/usr/bin/env bash
set -eu
if [[ ! -f config-user.properties ]] ; then
  echo "Enter the name of your node:"
  read name
  echo "Enter the boot key of your node. If you do not know what this is, press enter and one will be generated for you"
  read key
  if [[ $key == "" ]] ; then
    key=$(< /dev/urandom tr -dc a-f0-9 | head -c64)
  fi
  cat >config-user.properties <<EOF
nis.bootName = $name
nis.bootKey = $key
EOF

fi
