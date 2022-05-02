#!/usr/bin/env bash
print_hello_wold(){ echo "Hello, world!"; }
[[ "${BASH_SOURCE[0]}" == "$0" ]] && print_hello_world "$@"
