{
  SIZE=0
  size=$(
    find . -maxdepth 1 -type d |
    sed 1d|
    {
      SIZE=0
      while read dir; do
        size=$(
          find "$dir" -type f |
          xargs -d $'\n' -r stat -c %s|
          {
            SIZE=0
            while read size; do
              let SIZE+=size
            done
            printf "$SIZE"
          }
        )
        BDIR=`basename "${dir}"`
        printf "${size} ${BDIR}/\n" >&3
        let SIZE+=size
      done
      printf "$SIZE"
    }
  )
  let SIZE+=size
  size=$(
    find . -maxdepth 1 -type f |
    while read fi; do
      size=$(
        size=`stat -c %s "$fi"`
        BFI=`basename "${fi}"`
        printf "${size} ${BFI}\n" >&3
      )
      let SIZE+=size
    done
    let SIZE+=size
  )
  echo "$SIZE ."
} 3>&1