#!/bin/bash
set -e
type bash curl jq wget echo
set +e
a=$(
  echo 正在下载信息 >&2
  curl https://terraria.org/api/get/dedicated-servers-names
) ||
  {
    code=$?
    echo "下载信息时出错"
    exit $code
  }

while true; do

  {
    echo -n "这是一个泰拉瑞亚服务端下载脚本
请选择操作
1. 下载移动端服务器
2. 下载PC端服务器
3. 退出
#? "
  }
  
  read -r b
  
  case "$b" in
  1)
    name=$(
      echo "$a" | jq -r .[1]
    ) ||
      {
        code=$?
        echo 获取信息时发生错误
        exit $code
      }
    exec 3>"$name"
    wget -O- "https://terraria.org/api/download/mobile-dedicated-server/$name" >&3 &&
      echo" 下载成功" ||
      echo "下载失败"
      continue
  ;;
  2)
    name=$(
      echo "$a" | jq -r .[0]
    ) ||
      {
        code=$?
        echo 获取信息时发生错误
        exit $code
      }
    exec 3>"$name"
    wget -O- "https://terraria.org/api/download/pc-dedicated-server/$name" >&3 &&
      echo" 下载成功" ||
      echo "下载失败"
      continue
  ;;
  3)
    exit 0
  ;;
  *)
    echo "参数不正确" >&2
    continue
  ;;
  esac
done
