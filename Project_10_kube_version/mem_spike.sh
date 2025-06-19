#!/usr/bin/env bash
# mem_spike.sh — eat 80% RAM for 30s then free for 30s

TOTAL=$(grep MemTotal /proc/meminfo | awk '{print $2}')   # in KB
# target 80% in KB
TARGET=$(( TOTAL * 80 / 100 ))

while true; do
  echo "$(date +%T) ▶️ ALLOCATING ~80% RAM for 30s"
  # allocate an 80% chunk in a subshell
  (
    # /dev/shm is tmpfs; allocate there to avoid disk pressure
    dd if=/dev/zero of=/dev/shm/big.tmp bs=1K count=$TARGET status=none
    sleep 30
    rm -f /dev/shm/big.tmp
  ) &
  PID=$!

  sleep 30
  echo "$(date +%T) ⏹️ Freeing RAM"
  kill $PID 2>/dev/null
  wait $PID 2>/dev/null || true

  echo "$(date +%T) 💤 Resting for 30s"
  sleep 30
done
