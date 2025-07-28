#!/bin/bash
set -e

echo "🔍 Finding an nginx pod..."
POD=$(kubectl get pod -l app=nginx -o jsonpath='{.items[0].metadata.name}')

echo "🐚 Entering pod: $POD"
kubectl exec -it "$POD" -- sh -c "
  echo '🔗 Testing nginx on port 1234...'
  curl localhost:1234
"
