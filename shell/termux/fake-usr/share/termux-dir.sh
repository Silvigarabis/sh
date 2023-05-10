if [ ! -d "$TMPDIR" ]; then
  export TMPDIR=/data/data/com.termux/cache
fi
((
  exec >/dev/null 2>&1
  if [ -O /data/data/com.termux ]; then
    chmod +w \
      /data/data/com.termux \
      /data/data/com.termux/files/usr \
      /data/data/com.termux/files/fake-usr
    if [ ! -d /data/data/com.termux/cache ]; then
      rm -rf /data/data/com.termux/cache
      mkdir -p /data/data/com.termux/cache
    fi
    if [ ! -d /data/data/com.termux/files/usr/var/run ]; then
      rm -rf /data/data/com.termux/files/usr/var/run
      mkdir -p /data/data/com.termux/files/usr/var/run
    fi
    if [ "`realpath /data/data/com.termux/files/usr/tmp`" != /data/data/com.termux/cache ]; then
      rm -rf /data/data/com.termux/files/usr/tmp
      ln -s /data/data/com.termux/cache /data/data/com.termux/files/usr/tmp
    fi
    chmod 0777 /data/data/com.termux/cache /data/data/com.termux/files/usr/var/run
    findc(){
      find \
          bin \
          etc \
          lib \
          libexec \
          share \
          var \
          src \
          opt \
          -path var/run -prune -o \
        "$@"
    }
    chm(){
      findc -type f -executable -print0 | 
        xargs -0 -r chmod a+x
      findc -type d -writable -print0 |
        xargs -0 -r chmod a+rx
      findc -type f -writable -print0 |
        xargs -0 -r chmod a+r
    }
    cd "${PREFIX}" && chm
    cd "/data/data/com.termux/files/fake-usr" && chm
    chmod 555 \
      /data/data/com.termux \
      /data/data/com.termux/files \
      /data/data/com.termux/files/usr \
      /data/data/com.termux/files/fake-usr
  fi
) & )
