#!/usr/bin/env bash
set -u

: '
Task manager application can:

1. add "Content of the task"
2. delete 
3. list 2024-06-19T15:09:07

Give a verb as frist argument

Task are store in /tmp/task
'

path_task=/tmp/task
mkdir -p "$path_task"


demo3_task_manager_main(){
  if (( ! $# )); then
    task_usage;
    return 1
  fi
  case $1 in
    a|add) shift; task_add "$@"; return $?;;
    l|ls|list) shift; task_list "$@"; return $?;;
    r|remove) shift; task_remove "$@"; return $?;;
    *) task_usage; echo "Error: Unkown command: $*"; return 1;;
  esac
}

task_add(){
  local ts=$(date +'%Y-%m-%dT%H:%M:%S')
  echo "$*" > "$path_task/$ts.task"
}

task_remove(){
  local file="$path_task/$1.task"
  if [[ -w "$file" ]]; then
    return 1
  fi
  unlink "$file"
}

task_list(){
  for file in "$path_task"/*.task; do 
    [[ -r "$file" ]] || return 1
    local ts=${file##"$path_task/"}; ts=${ts%%.task}
    local task=$(< "$file"); task=${task//$'\n'/<br />}
    echo "$ts : $task"
  done
}

task_usage(){
  sed -n "/^: '/,/^'/p" "${BASH_SOURCE[0]}" | sed '1d;$d'
}

if ! (return 0 2>/dev/null); then
  demo3_task_manager_main "$@"
  exit $?
fi
