## Syllabus

> As of June 2026

![[CKA-Syllabus.png]]

### 1. Troubleshooting (30%)

This is the most heavily weighted section. You must be able to:

- [ ] **Cluster & Nodes:** Diagnose why a node is "NotReady" or why a control plane component is failing.
- [ ] **Resource Usage:** Monitor CPU/Memory and evaluate container logs (`stdout`/`stderr`).
- [ ] **Networking:** Fix Service-to-Pod connectivity and resolve CoreDNS issues.

### 2. Cluster Architecture, Installation & Configuration (25%)

- [ ] **RBAC:** Create Roles, ClusterRoles, and Bindings to manage user permissions.
- [ ] **Kubeadm:** This is the standard tool for the exam; you'll need to know how to build a cluster or upgrade it.
- [ ] **HA Control Plane:** Understand how to make the API server and Etcd highly available.
- [ ] **Tooling:** Use **Helm** and **Kustomize** to deploy applications.

### 3. Services & Networking (20%)

- [ ] **Connectivity:** Understand how Pods talk to each other across nodes.
- [ ] **Network Policies:** Define "firewall" rules between namespaces or labels.
- [ ] **Ingress & Gateway API:** Manage external traffic. **Note:** The Gateway API is a newer addition you'll definitely see in 2026.
- [ ] **CoreDNS:** Configure and troubleshoot service discovery.

### 4. Workloads & Scheduling (15%)

- [ ] **Deployments:** Perform rolling updates and instant rollbacks.
- [ ] **Config:** Use ConfigMaps and Secrets to inject environment variables.
- [ ] **Autoscaling:** Configure the Horizontal Pod Autoscaler (HPA).
- [ ] **Scheduling:** Master Node Affinity, Taints, and Tolerations.

### 5. Storage (10%)

- [ ] **Dynamic Provisioning:** Use StorageClasses to create storage on the fly.
- [ ] **PV & PVC:** Bind Persistent Volumes to Claims and mount them into Pods.
- [ ] **Policies:** Understand "Retain," "Delete," and "Recycle" reclaim policies.
