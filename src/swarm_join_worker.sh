#!/usr/bin/env bash
set -e

MANAGER_IP="$1" 

TOKEN_FILE="/vagrant/worker_token.txt"
for i in {1..30}; do
  if [ -s "$TOKEN_FILE" ]; then
    break
  fi
  sleep 2
done

WORKER_TOKEN=$(cat "$TOKEN_FILE")

if ! docker info 2>/dev/null | grep -q "Swarm: active"; then
  sudo docker swarm join --token "${WORKER_TOKEN}" "${MANAGER_IP}:2377"
fi
