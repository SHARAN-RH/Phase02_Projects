#!/usr/bin/env bash
# Continuously hit both services until you stop it with Ctrl-C (or kill)
echo "Starting continuous load on service-a and service-b…"
while true; do
  curl -s http://localhost:8001/ >/dev/null &
  curl -s http://localhost:8002/ >/dev/null &
  sleep 0.1
done
