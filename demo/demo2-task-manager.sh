#!/usr/bin/env bash
set -u

path_task=/tmp/task
mkdir -p "$path_task"

demo2_task_manager_main(){
  if (( ! $# )); then
    echo "Give a subcommand in: add, list, remove"
    return 1
  fi
  case $1 in
    a|add) shift; task_add "$@"; return $?;;
    l|list) shift; task_list "$@"; return $?;;
    r|remove) shift; task_remove "$@"; return $?;;
    assert) shift; make_test "$@"; return $?;;
    *) echo "Task Manager Error: Unkown command: $*"; return 1;;
  esac
}

task_remove(){
  local file="$path_task/$1.task"

  if [[ ! -e "$file" ]]; then
    echo "Esta tarea no existe: $file"
    return 1
  fi

  unlink "$file"
}


task_list(){
  for file in "$path_task"/*.task; do
    local ts=${file#"$path_task/"}; ts=${ts%.task}
    local task=$(< "$file"); task=${task//$'\n'/:}
    echo "$ts : $task"
  done
}


task_add(){
  : 'Add task arg* to task list'
  echo $#
  if (( ! $# )); then
    echo "Give the tak to do in arguments"
    return 1
  fi
  local date=$( date +'%Y-%m-%dT%H:%M:%S' )
  echo "$*" > "$path_task"/"$date".task
}


assert(){
  local b_not=0; [[ not == "$1" ]] && { b_not=1; shift ; }
  out=$("$@"); local res=$((b_not ? !$? : $?))
  echo "[$res] $* => $out"
}

make_test(){
  tm(){ ./demo2-task-manager.sh "$@"; }
  assert not tm
  assert tm add "toto"
  assert not tm add
}


if ! (return 0 2>/dev/null); then
  demo2_task_manager_main "$@"; res=$?
  exit "$res"
fi
