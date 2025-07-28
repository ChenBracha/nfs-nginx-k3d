kcat << 'EOF' > README.md
# 🚀 NFS with K3d and NGINX
# 📦 NFS + K3D + NGINX Deployment (macOS)

This project demonstrates a simple Kubernetes setup on macOS using `k3d`, where:
- A local folder (`storage/index.html`) is mounted as NFS-like shared storage.
- NGINX serves content from this shared volume.
- The deployment is fully automated with scripts.

---

## 🧱 Project Structure

```bash
.
├── README.md             # This file
├── all.sh                # One-click deploy: create, deploy, test
├── clean-up.sh           # Delete k3d cluster, PV, PVC, and cleanup
├── deploy.sh             # Apply Kubernetes manifests (YAML)
├── k3d-create.sh         # Create K3d cluster with volume
├── k8s/
│   ├── configmap.yaml    # Custom NGINX config (port 1234)
│   ├── deployment.yaml   # NGINX deployment with PVC
│   ├── pv.yaml           # Persistent Volume using hostPath
│   └── pvc.yaml          # Persistent Volume Claim
├── storage/
│   └── index.html        # Static HTML file served by NGINX
└── test.sh               # Curl test to verify NGINX output
