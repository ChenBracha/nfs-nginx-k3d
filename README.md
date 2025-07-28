# Easy K3d nginx + Shared Volume Demo (macOS)

This is a simple Kubernetes project to run an nginx deployment with shared volume access using hostPath (compatible with macOS + K3d).

## 🧱 Project Structure

- 3 nginx pods
- All serve a shared `index.html` stored on your Mac at `~/k3d-nfs-share`
- nginx listens on port 1234 (via ConfigMap override)

## 🚀 Quick Start

1. Create the shared folder on your Mac:
```bash
mkdir -p ~/k3d-nfs-share
echo "NFS StorageClass To Container" > ~/k3d-nfs-share/index.html
