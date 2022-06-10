#!/usr/bin/env bash

set -euo pipefail

token="$1"
bastion_key="$2"
environment="$3"
wonderland_manifest="$4"
timeout="$5"
delete="$6"
workspace="$7"
cli_version="$8"

if [ "$workspace" != "prod" ]; then
    echo "Warning: 'workspace' parameter is deprecated please use 'environment' instead" >&2
    if [ "$environment" != "prod" ]; then
        echo "Error: You can either use 'workspace' ($workspace) or 'environment' ($workspace) not both!" >&2
        exit 1
    fi
    environment="$workspace"
fi

function log() {
  echo "$(date -u) $*"
}

trap 'rc=$?; log "$rc: There was a problem. Please take a look at https://backstage.jimdex.net/docs/default/component/wonderland2-k8s-operator/How-To/Debug/ for troubleshooting"; exit $rc' ERR

if [ $# -lt 8 ]; then
  log "Not enough arguments"
  exit 1
fi

echo "::debug::Downloading the WL2 CLI"
dl_uri="$(curl --silent --fail --show-error -H "Authorization: token $1" "https://api.github.com/repos/Jimdo/wonderland2-cli/releases/tags/$cli_version" | jq '.assets[] | select(.name == "wl2-linux-amd64") | .url' -r)"
curl -L --silent --fail --show-error --output /usr/local/bin/wl2 -H "Authorization: token $1" -H 'Accept:application/octet-stream' "$dl_uri"
chmod +x /usr/local/bin/wl2

log "Setting WONDERLAND_GITHUB_TOKEN"
export WONDERLAND_GITHUB_TOKEN="$1"

log "Setting ssh key"
mkdir -p /root/.ssh/
echo "$bastion_key" >/root/.ssh/id_rsa
chmod 600 /root/.ssh/id_rsa
echo "StrictHostKeyChecking no" >/root/.ssh/config

service_name=$(yq eval '.metadata.name' "$4")

if $delete == "true"; then
  log "Deleting $service_name from Wonderland 2"
  wl2 --environment="$environment" kubectl delete -f "$wonderland_manifest"
else
  log "Deploying $service_name to Wonderland 2"
  wl2 --environment="$environment" kubectl apply -f "$wonderland_manifest"

  log "Waiting for service to become available"
  # jsonpath condition is supported since kubectl 1.23
  if wl2 --environment="$environment" kubectl wait --for=jsonpath='{.status.phase}=RUNNING' "WonderlandService/$service_name" --timeout="$timeout"; then
    log "Deployed $service_name to Wonderland 2 successfully"
    log "Getting service status"
    wl2 --environment="$environment" kubectl get ws "$service_name"
  else
    log "Failed to get deployment for service $service_name"
    exit 1
  fi
fi
