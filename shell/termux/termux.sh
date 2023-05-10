#/system/bin/sh
if [ ! -r /data/data/com.termux/files/usr ]; then
  printf "'/data/data/com.termux/files/usr' can't be accessed!\n"
  exit 126
fi

cd "${HOME:-${PWD}}"

export \
  PREFIX='/data/data/com.termux/files/usr' \
  EXTERNAL_STORAGE='/sdcard' \
  LANG="${LANG:-C.UTF-8}" \
  PATH='/data/data/com.termux/files/usr/bin' \
  TMPDIR='/data/data/com.termux/files/usr/tmp' \
  ANDROID_DATA='/data' \
  ANDROID_ROOT='/system'
if [ -n "$LD_LIBRARY_PATH" ]; then
  LD_LIBRARY_PATH="$PREFIX/lib:$LD_LIBRARY_PATH"
  export LD_LIBRARY_PATH
fi
login="/data/data/com.termux/files/usr/bin/login"

if [ -x "${login}" ]; then
  exec "${login}"
else
  printf "exec termux failed\n"
  exec /system/bin/sh -l
fi

