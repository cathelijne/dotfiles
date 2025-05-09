#!/bin/bash

# Usage: ./delete.-stuck-namespace.sh $NAMESPACE
# More information: https://www.ibm.com/docs/en/cloud-private/3.1.1?topic=console-namespace-is-stuck-in-terminating-state

set -eu

PVC=$1
echo "Deleting $PVC"

UPLOAD=$(kubectl get pvc $PVC -o json | jq 'del(.metadata.finalizers[])')

kubectl proxy &
proxy_pid=$!
echo "Started a kubectl proxy with PID $proxy_pid"

until curl -fsSL http://localhost:8001/ > /dev/null; do
    sleep 5
done

curl -k -H "Content-Type: application/json" -X PUT -d "$UPLOAD"  http://127.0.0.1:8001/api/v1/core/$PVC/finalize

function cleanup {
    echo "Stopping kubectl proxy" >&2
    kill $proxy_pid
}

trap cleanup EXIT
