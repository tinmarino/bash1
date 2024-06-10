#!/usr/bin/env bash

#echo -e "HTTP/2 200 OK\r\n
echo -e "Content-Type: text/plain\r\n"

print_args(){
  ### Print input arguments, one per line
  local cnt=1
  for s_arg in "$@"; do
    echo "$((cnt++))/ $s_arg"
  done
}

pring_args "$@"

env | sort
