#!/bin/bash
# A Program to Download Latest Terraria Dedicated Server
get_server_name_api="https://terraria.org/api/get/dedicated-servers-names"
download_pc_api="https://terraria.org/api/download/pc-dedicated-server"
download_mobile_api="https://terraria.org/api/download/mobile-dedicated-server"
main(){
  get_server_name
  __safe_exec type bash jq wget echo
  while true; do
    __print_help
    read -r line
    case "${line}" in
    1) download_mobile_server;;
    2) download_pc_server;;
    3) exit 0;;
    *) continue;;
    esac
  done
}
__safe_exec(){
  "$@"
  local code=$?
  if [[ ${code} != 0 ]]
  then
    exit ${code}
  fi
}
__print_help(){
    echo -n "这是一个泰拉瑞亚服务端下载脚本
请选择操作
1. 下载移动端服务器
2. 下载PC端服务器
3. 退出
#? "
  }
get_pc_name(){
  name=$(echo "${dedicated_servers_names}" | jq -r .[0])
  if [[ -z ${name} ]]; then
    echo "无法获取名称"
    exit 1
  fi
}
get_mobile_name(){
  name=$(echo "${dedicated_servers_names}" | jq -r .[1])
  if [[ -z ${name} ]]; then
    echo "无法获取名称"
    exit 1
  fi
}
download_pc_server(){
  local name
  get_pc_name
  __safe_exec wget -O "${name}" "${download_pc_api}/${name}"
}
download_mobile_server(){
  local name
  get_mobile_name
  __safe_exec wget -O "${name}" "${download_mobile_api}/${name}"
}
get_server_name(){
  echo 下载服务器信息
  dedicated_servers_names=$(__safe_exec wget -O- "${get_server_name_api}")
  if [[ -z ${dedicated_servers_names} ]]; then
    echo "无法获取名称"
    exit 1
  fi
}
main
