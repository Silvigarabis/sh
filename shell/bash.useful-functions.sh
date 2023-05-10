# function
#uuid(){
#  local c i args
#  for ((i=${1:-1};i>c;c++)); do
#      args[${c}]=/proc/sys/kernel/random/uuid
#  done
#  if [ ${#args[*]} = 0 ]; then
#    return 0
#  else
#    cat ${args[@]}
#  fi
#}
alias mct='base=1626144934;while sleep 1; do s=$(date +%s); now=$(echo "(($s-$base)%1200)*20"|bc); printf "\r$now"; done'
del(){
  local cmd='mv -v' i
  if [ "$1" = -f ]; then
    shift
    cmd='mv -vf'
  fi
  local rec="$TMPDIR/rec-`id -u`"
  mkdir -p "$rec"
  for i in "$@"; do
    eval "$cmd" '"${i}" "$rec/$RANDOM$RANDOM$RANDOM"'
  done
}

