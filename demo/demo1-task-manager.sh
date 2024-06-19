#!/usr/bin/env bash

path_task=/tmp/task

demo1_task_manager_main(){
  case $1 in
    a|add) shift; task_add "$@"; return $?;;
    l) shift; task_list "$@"; return $?;;
    r) shift; task_remove "$@"; return $?;;
    *) echo "Unkown command: $*"; return $?;;
  esac
}

task_remove(){
  # Clause
  if (( $# < 1)); then
    >&2 echo "Give me an input, 'all' to delete all tasks"
    return
  fi

  # Clause
  if [[ all == "$1" ]]; then
    rm "$path_task"/*.task
    return
  fi

  local file="$path_task/$1".task  # Warning insecure

  if [[ -e "$file" ]]; then
    >&2 echo "removing $file"
    unlink "$file"
  fi
}

task_add(){
  local file_task=$(date +'%Y-%m-%dT%H:%M:%S')
  echo "$*" > "$path_task/$file_task".task
}


task_list(){
  local file_task=''
  for file_task in "$path_task"/*; do
    local ts=${file_task#"$path_task/"}; ts=${ts%.task}
    echo "$ts: $(<"$file_task")"
  done
}


if ! (return 0 2>/dev/null); then
  demo1_task_manager_main "$@"; res=$?
  exit "$res"
fi
