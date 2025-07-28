#!/bin/bash
set -e

echo "📁 Creating shared NFS folder..."
mkdir -p ~/k3d-nfs-share
echo "NFS StorageClass To Container" > ~/k3d-nfs-share/index.html

echo "🔁 Recreating k3d cluster..."
k3d cluster delete nfs-demo || true
k3d cluster create nfs-demo --volume ~/k3d-nfs-share:/data@all
