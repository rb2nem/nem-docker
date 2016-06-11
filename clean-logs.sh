#!/bin/bash

# delet elog files older than the 9th logfile 
find . -regextype posix-awk -regex '.*(servant|nis|ncc)-[[:digit:]]{2}.log' -exec rm \{\} \;
