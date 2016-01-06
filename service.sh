#!/bin/bash

if [[ $# < 1 ]]; then
  echo "Usage: $0 [start|stop|restart|status] [ncc|nis]"
  exit 1
fi


./supervisorctl.sh $@


if [[ "$*" =~ ncc && $1 == "start" ]]; then
  echo "You can access the NEM Community Client at http://localhost:8989/"
fi
