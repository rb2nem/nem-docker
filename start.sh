#!/bin/bash
set -ex

cd package


tmux new -d  -s "nem"

for var in "$@"
do
    echo $var
    if [[ $var == "nis" ]]; then
      tmux split-window -t "nem"  ./nix.runNis.sh 
    elif [[ $var == "ncc" ]]; then
      tmux split-window -t "nem" ./nix.runNcc.sh 
    else
      echo "$var: command unknown"
    fi
done

tmux attach -t nem
