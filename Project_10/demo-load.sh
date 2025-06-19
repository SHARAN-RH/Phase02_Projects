#!/usr/bin/env bash
# Fire concurrent requests at both services to light up the dashboards
echo "Generating load on service-a and service-b for 60s..."
end=$((SECONDS+60))
while [ $SECONDS -lt $end ]; do
  curl -s http://localhost:8001/ >/dev/null &
  curl -s http://localhost:8002/ >/dev/null &
  sleep 0.1
done
wait
echo "Done!"
