#!/usr/bin/env bash
#
# oscillate_load.sh — spike CPU & RAM to ~80% for 30 s, then back to ~5% for 30 s, forever.
#

# Duration of each phase
SPIKE=30
REST=30

# CPU parameters
CPUS=$(nproc)
SPIKE_CPU_LOAD=80   # target 80% load
REST_CPU_LOAD=5     # target 5% load

# RAM parameters
TOTAL_MEM_BYTES=$(awk '/Mem:/ {print $2}' /proc/meminfo)
# compute 80% and 5% of total memory
SPIKE_MEM_BYTES=$(( TOTAL_MEM_BYTES * 80 / 100 ))
REST_MEM_BYTES=$(( TOTAL_MEM_BYTES * 5  / 100 ))

# Ensure stress-ng is installed
if ! command -v stress-ng >/dev/null 2>&1; then
  echo "Please install stress-ng: sudo apt update && sudo apt install -y stress-ng"
  exit 1
fi

echo "Oscillating load: SPIKE 80% → REST 5% every ${SPIKE}s/${REST}s"
echo "  CPUs: $CPUS cores"

while true; do
  ts=$(date +'%T')
  echo "$ts ▶️ SPIKE: CPU ${SPIKE_CPU_LOAD}% & RAM ~80% for ${SPIKE}s"
  stress-ng \
    --cpu "$CPUS" \
    --cpu-load "$SPIKE_CPU_LOAD" \
    --vm 1 \
    --vm-bytes "${SPIKE_MEM_BYTES}B" \
    --vm-keep \
    --timeout "${SPIKE}s" \
    >/dev/null 2>&1 &

  PID=$!
  sleep "$SPIKE"

  # In case it’s still running, kill it
  if kill -0 "$PID" 2>/dev/null; then
    echo "$ts ⏹️ Killing SPIKE"
    kill "$PID"
  fi

  ts=$(date +'%T')
  echo "$ts 💤 REST: CPU ${REST_CPU_LOAD}% & RAM ~5% for ${REST}s"
  stress-ng \
    --cpu "$CPUS" \
    --cpu-load "$REST_CPU_LOAD" \
    --vm 1 \
    --vm-bytes "${REST_MEM_BYTES}B" \
    --vm-keep \
    --timeout "${REST}s" \
    >/dev/null 2>&1 &

  PID2=$!
  sleep "$REST"

  if kill -0 "$PID2" 2>/dev/null; then
    echo "$ts ⏹️ Killing REST"
    kill "$PID2"
  fi
done
