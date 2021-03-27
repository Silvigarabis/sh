#输出时间、命令执行状态
PSTATUS=("${PIPESTATUS[@]}")
USER=`whoami`
ID=`id -u`
time=`date +%H:%M:%S.%N`

printf "\n>>>"
printf "[${time}]"
printf "\[\\e[7m\]<\!>\[\\e[0m\]"
printf "{${PSTATUS[*]}}"
if [[ $(jobs -p|wc -l) != 0 ]]; then
  printf "=J="
fi
printf "\n"

#GIT
if type git >/dev/null 2>&1; then
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    GIT_BRANCH=`git branch --show-current`
    GIT_STATUS=$(
      git status -s|sed 's/^\(.\).*$/\1/g'|sort|uniq|xargs
    )
    printf "[GIT]: B{${GIT_BRANCH}} S{${GIT_STATUS}}"
    printf "\n"
  fi
fi

BASEDIR=`basename "${PWD}"`
printf "\[\e[30;46m\]"
if [[ ${PWD} = ${HOME} ]]; then
  printf "~"
else
  length=${#BASEDIR}
  if ((length>20)); then
    printf "${BASEDIR}"|sed 's/^\(.\{3\}\).*/\1/'
    printf "\[\e[33m\]...\[\e[30m\]"
    printf "${BASEDIR}"|sed 's/.*\(.\{3\}\)$/\1/'
  else
    printf "${BASEDIR}"
  fi
fi
printf "\[\e[0m\] "
