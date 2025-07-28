#!/bin/bash
set -e

echo "📦 Creating static PV and PVC"
kubectl apply -f k8s/pv.yaml
kubectl apply -f k8s/pvc.yaml

echo "⚙️  Applying nginx ConfigMap and Deployment"
kubectl apply -f k8s/configmap.yaml
kubectl apply -f k8s/deployment.yaml

echo "⏳ Waiting for nginx rollout to finish..."
kubectl rollout status deployment/nginx-deployment

echo "✅ Deployment complete!"
kubectl get pods -l app=nginx -o wide
