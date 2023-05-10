pstatus=("${PIPESTATUS[@]}")
time=$(date +%H:%M:%S.%N)
ps1="\n>>>[${time}]\[\\e[7m\]<\!>\[\\e[0m\]{${pstatus[*]}}"
jobs_procs=($(jobs -p))
jobs_count=0
for jobs_proc in "${jobs_procs[@]}"; do
  let jobs_count++
done
if [[ ${jobs_count} != 0 ]]; then
  ps1+=" J+${jobs_count}"
fi
ps1+="\n"

git_cmd="$(command -v git)"
if [[ -n ${git_cmd} ]]; then
  git_dir="$("${git_cmd}" rev-parse --absolute-git-dir 2>&-)"
  if [[ -n ${git_dir} ]]; then
    git_is_inside_work_tree=$("${git_cmd}" rev-parse --is-inside-work-tree)
    git_is_inside_git_dir=$("${git_cmd}" rev-parse --is-inside-git-dir)
    git_current_branch=$("${git_cmd}" branch --show-current)
    git_head_sha1=$("${git_cmd}" rev-parse HEAD)
    ps1+="[GIT]"
    if [[ ${git_is_inside_work_tree} = true ]]; then
      git_toplevel=$("${git_cmd}" rev-parse --show-toplevel)
      git_status=$("${git_cmd}" status -s|sed -E 's/^(.)(.).*$/\\n\1\\n\2/g' | sort | uniq | xargs)
      git_prefix=$("${git_cmd}" rev-parse --show-prefix)
      ps1+="[TOP]: ${git_toplevel}\[\e[1m/${git_prefix}\e[0m"
      if [[ -n ${git_status} ]]; then
        ps1+=" {${git_status}}"
      fi
    elif [[ ${git_is_inside_git_dir} = true ]]; then
      ps1+="[DIR]: ${git_dir}"
    fi
    ps1+="\n"
    if [[ -n ${git_current_branch} ]]; then
      git_head_sha1_short="${git_head_sha1:0:7}"
      ps1+="B: ${git_current_branch} SHA: ${git_head_sha1_short}"
    else
      ps1+="SHA: ${git_head_sha1}"
    fi
    ps1+="\n"
  fi
fi
ps1+="\[\e[30;46m\]"
if [[ ${PWD} = ${HOME} ]]; then
  ps1+="~"
else
  base="$(basename "${PWD}")"
  base_length=${#base}
  if ((base_length>20)); then
    ps1+="$(printf "${base}"|sed -E 's/^(.{3}).*(.{3})/\1\[\e[33m\]...\[\e[30m\]\2/')"
  else
    ps1+="${base}"
  fi
fi
ps1+="\[\e[0m\] "
printf "$ps1"
