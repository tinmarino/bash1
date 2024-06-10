#!/usr/bin/env bash

path_task=/var/www/task   # Warning HARDCODE

task_demo(){
  : 'Main dispatcher'
  [[ -d "$path_task" ]] || mkdir -p "$path_task"
  while (( 0 != $# )); do
    case $1 in
      a|add) shift; task_add "$@"; return $?;;
      r|rm|delete) shift; task_delete "$@"; return $?;;
      l|list|ls) shift; task_list "$@"; return $?;;
      *)
        task_add "$@"; return $?;;
    esac
  done
  return $?
}


task_add(){
  : 'Touch'
  file_task=$(date +'%Y-%m-%dT%H:%M:%S').task
  echo "$*" > "$path_task/$file_task"
}


task_delete(){
  : 'Rm'
  task=$(get_task_path "$1")
  # Clause: task must exist
  if [[ ! -e "$task" ]]; then
    echo "Error task $task do not exist"
    return 1
  fi

  rm "$task"
}


task_list(){
  : 'Ls'
  for file in "$path_task"/*.task; do
    ts=${file##"$path_task/"}
    ts=${ts%%.task}
    [[ -e "$file" ]] || continue
    echo -n "$ts: "
    cat "$file"
  done
}


get_task_path(){ echo -n "$path_task/$1.task"; }
print_args(){
  ### Print input arguments, one per line
  local cnt=1
  for s_arg in "$@"; do
    echo "$((cnt++))/ $s_arg!"
  done
}


if ! (return 0 2>/dev/null); then
  >&2 echo "--> $0 starting with $*."
  >&2 print_args "$@"
  if [[ -v QUERY_STRING ]]; then
    IFS='&' read -ra a_args <<< "$QUERY_STRING"
    set -- "${a_args[@]}"
    echo -e "Content-Type: text/plain\r\n"
  fi
  task_demo "$@"; res=$?
  >&2 echo "<-- $0 returned with $res."
  exit "$res"
fi
