#!/usr/bin/env bash
# cpu_spike.sh — spin all CPUs at ~100% for 30s, then rest 30s

while true; do
  echo "$(date +%T) ▶️ SPIKING CPU to ~100% for 30s"
  # Launch one busy‐loop per core in background
  for _ in $(seq 1 $(nproc)); do
    ( while :; do :; done ) &
    PIDS="$PIDS $!"
  done

  # Let them run 30s
  sleep 30

  echo "$(date +%T) ⏹️ Killing CPU spike"
  kill $PIDS 2>/dev/null
  unset PIDS

  echo "$(date +%T) 💤 Resting for 30s"
  sleep 30
done
