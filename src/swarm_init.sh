#!/usr/bin/env bash
set -e

MANAGER_IP="192.168.56.10"

if ! docker info 2>/dev/null | grep -q "Swarm: active"; then
  sudo docker swarm init --advertise-addr ${MANAGER_IP}
fi

WORKER_TOKEN=$(sudo docker swarm join-token -q worker)
echo "${WORKER_TOKEN}" | sudo tee /vagrant/worker_token.txt > /dev/null

MANAGER_TOKEN=$(sudo docker swarm join-token -q manager)
echo "${MANAGER_TOKEN}" | sudo tee /vagrant/manager_token.txt > /dev/null
