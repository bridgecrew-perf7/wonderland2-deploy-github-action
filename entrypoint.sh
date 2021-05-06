#!/usr/bin/env bash

set -euo pipefail

function log() {
    echo "$(date -u) $*"
}

if [ $# -lt 4 ]; then
    log "Not enough arguments"
    exit 1
fi

log "Setting WONDERLAND_GITHUB_TOKEN"
export WONDERLAND_GITHUB_TOKEN="$1"

log "Setting ssh key"
mkdir -p /root/.ssh/
echo "$2" > /root/.ssh/id_rsa
chmod 600 /root/.ssh/id_rsa
echo "StrictHostKeyChecking no" > /root/.ssh/config

log "Deploying application to Wonderland 2"
wl --workspace="$3" kubectl apply -f "$4"
log "Deployment finished"
