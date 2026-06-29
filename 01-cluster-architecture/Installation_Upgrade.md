# Cluster Installation and Upgrade

## 1. Extension Interfaces and Infrastructure

- **Infrastructure Provisioning:** Kubernetes nodes require servers, networks, and storage. Tools like Ansible or Terraform automate this process, though infrastructure provisioning itself falls outside the core scope of Kubernetes administration.

![Kubernetes CRI CSI and CNI Interfaces](src/kubernetes-cri.png)

- **Container Network Interface (CNI):** Responsible for establishing network connections between Pods. Popular plug-ins include Calico, flannel, Cilium, and cloud-specific options like AWS VPC CNI.
- **Container Runtime Interface (CRI):** Manages the lifecycle of containers and handles resource requests. Options include containerd (the default/most popular), CRI-O, and Docker Engine via cri-dockerd.
- **Container Storage Interface (CSI):** A standard for integrating third-party block and file storage systems (e.g., AWS EBS CSI, Rook/Ceph, Portworx) with containerized workloads.

## 2. Installing a Cluster with `kubeadm`

`kubeadm` is the low-level command-line tool used for cluster bootstrapping operations.

**Initialize the Control Plane Node:**

```bash
sudo kubeadm init --pod-network-cidr=10.244.0.0/16
```

You can also declare the API server IP address using `--apiserver-advertise-address` or target a specific version with `--kubernetes-version`.

**Configure `kubeconfig` for the Regular User:**

```bash
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

**Install the Pod Network Add-on (CNI):**

```bash
kubectl apply -f https://github.com/flannel-io/flannel/releases/latest/download/kube-flannel.yml
```

Verify that the control plane node transitions from `NotReady` to `Ready` status.

**Join Worker Nodes:**
Run the join command provided by the `kubeadm init` output on your worker nodes:

```bash
sudo kubeadm join 172.16.0.5:6443 --token <your-token> \
  --discovery-token-ca-cert-hash sha256:<your-hash>
```

> If you lose the join command, you can retrieve it on the control plane by running `kubeadm token create --print-join-command`.

## 3. High-Availability (HA) Topologies

HA clusters are necessary for scaling and redundancy.

- **Stacked etcd Topology:** The `etcd` instance is colocated on the control plane nodes. A minimum of three control plane nodes is recommended for redundancy, and worker nodes communicate with them via a load balancer.
- **External etcd Node Topology:** `etcd` runs on dedicated, separate machines rather than on the control plane nodes. This decouples etcd functionality and improves redundancy if a control plane node is lost, though it requires twice as many hosts.

## 4. Upgrading a Cluster Version

When upgrading, you should only jump up by a single minor version or multiple patch versions at a time (e.g., 1.31.0 to 1.31.3 or 1.31.0 to 1.32.0). Upgrades must be done on control plane nodes one at a time.

**Step 1: Upgrade the Control Plane Node**
Unhold, install, and hold the target `kubeadm` version:

```bash
sudo apt-mark unhold kubeadm
sudo apt-get update && sudo apt-get install -y kubeadm=1.31.5-1.1
sudo apt-mark hold kubeadm
```

Plan and apply the upgrade:

```bash
sudo kubeadm upgrade plan
sudo kubeadm upgrade apply v1.31.5
```

Drain the control plane node to safely evict running workloads:

```bash
kubectl drain kube-control-plane --ignore-daemonsets
```

Upgrade the `kubelet` and `kubectl`, then restart the kubelet service:

```bash
sudo apt-mark unhold kubelet kubectl
sudo apt-get update && sudo apt-get install -y kubelet=1.31.5-1.1 kubectl=1.31.5-1.1
sudo apt-mark hold kubelet kubectl
sudo systemctl daemon-reload
sudo systemctl restart kubelet
```

Uncordon the node to allow workloads to be scheduled again:

```bash
kubectl uncordon kube-control-plane
```

**Step 2: Upgrade Worker Nodes**
First, install the targeted `kubeadm` version using the same apt-get commands as above. Then, upgrade the node's configuration:

```bash
sudo kubeadm upgrade node
```

Drain the worker node:

```bash
kubectl drain kube-worker-1 --ignore-daemonsets
```

Upgrade the `kubelet` and `kubectl` on the worker node, and restart the service:

```bash
sudo apt-mark unhold kubelet kubectl
sudo apt-get update && sudo apt-get install -y kubelet=1.31.5-1.1 kubectl=1.31.5-1.1
sudo apt-mark hold kubelet kubectl
sudo systemctl daemon-reload
sudo systemctl restart kubelet
```

Finally, uncordon the worker node:

```bash
kubectl uncordon kube-worker-1
```
