#!/bin/bash
set -e

echo "🧹 Deleting k3d cluster..."
k3d cluster delete nfs-demo || true

echo "🗑️ Deleting PV and PVC..."
kubectl delete pvc static-nfs-pvc --ignore-not-found
kubectl delete pv static-nfs-pv --ignore-not-found

echo "🧺 Removing NFS shared folder..."
rm -rf ~/k3d-nfs-share

echo "✅ Cleanup complete."
