# 🚀 NFS with K3d and NGINX on macOS

This project demonstrates how to deploy an NGINX server on a local `k3d` Kubernetes cluster using a host-mounted folder to simulate NFS. It includes PersistentVolumes, ConfigMaps, and a custom NGINX configuration running on port `1234`.

Everything is automated using Bash scripts for easy one-command setup.

---

## 📁 Project Structure

```
.
├── README.md             # Project documentation
├── all.sh                # One-command setup: clean → create → deploy → test
├── clean-up.sh           # Delete cluster, PVC, PV, and volume
├── deploy.sh             # Deploy all Kubernetes manifests
├── k3d-create.sh         # Create k3d cluster with shared volume
├── k8s/
│   ├── configmap.yaml    # NGINX config (port 1234)
│   ├── deployment.yaml   # NGINX with PVC and config
│   ├── pv.yaml           # PersistentVolume using hostPath
│   └── pvc.yaml          # PersistentVolumeClaim
├── storage/
│   └── index.html        # HTML served by NGINX
└── test.sh               # Curl from inside pod to verify output
```

---

## 🧠 What You'll Learn

- Deploying a local `k3d` cluster on macOS
- Simulating NFS with a hostPath volume
- Creating a PersistentVolume (PV) and PersistentVolumeClaim (PVC)
- Using a ConfigMap to configure NGINX on a custom port
- Automating all setup with shell scripts

---

## 🛠️ Prerequisites

- [Docker](https://www.docker.com/)
- [k3d](https://k3d.io/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [Git](https://git-scm.com/)

---

## 🚀 Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/<your-username>/nfs-nginx-k3d.git
cd nfs-nginx-k3d
```

### 2. Run Everything

```bash
./all.sh
```

This will:
- Delete any old setup
- Create a `k3d` cluster
- Mount the local folder as a volume
- Deploy PV, PVC, ConfigMap, and NGINX
- Test the output from inside a pod

---

## 📜 Kubernetes Manifests

### `pv.yaml`

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: static-nfs-pv
spec:
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteMany
  hostPath:
    path: "/data"
  persistentVolumeReclaimPolicy: Retain
```

### `pvc.yaml`

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: static-nfs-pvc
spec:
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 1Gi
```

### `configmap.yaml`

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: nginx-config
data:
  default.conf: |
    server {
      listen 1234;
      location / {
        root /usr/share/nginx/html;
        index index.html;
      }
    }
```

### `deployment.yaml`

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
        - name: nginx
          image: nginx
          ports:
            - containerPort: 1234
          volumeMounts:
            - name: html
              mountPath: /usr/share/nginx/html
            - name: conf
              mountPath: /etc/nginx/conf.d
      volumes:
        - name: html
          persistentVolumeClaim:
            claimName: static-nfs-pvc
        - name: conf
          configMap:
            name: nginx-config
```

---

## 🧪 Test Script

The script `test.sh` checks the NGINX output by running curl inside one of the pods:

```bash
kubectl exec -it $(kubectl get pod -l app=nginx -o jsonpath='{.items[0].metadata.name}') -- \
  sh -c "apt update && apt install -y curl && curl localhost:1234"
```

Expected output:

```
NFS StorageClass To Container
```

---

## 🧹 Cleanup

```bash
./clean-up.sh
```

This removes:
- The k3d cluster
- PV and PVC
- The shared volume folder

---

## 📌 Notes

- Works on **macOS only** using hostPath via k3d `--volume` flag
- Designed for **local testing** and **learning volume management**
- Does not use Helm or real NFS server — for simplicity

---

## 🙋‍♂️ Author

User:  Chen Bracha

---

## 📄 License

MIT License
