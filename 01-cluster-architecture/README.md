# Cluster Architecture, Installation & Configuration (25%)

This section covers the management, installation, and configuration of a Kubernetes cluster, making up 25% of the CKA exam.

## Topics (2026 Syllabus)

- **Manage Role-Based Access Control (RBAC)**
  - Creating Roles and ClusterRoles.
  - Creating RoleBindings and ClusterRoleBindings.
  - Managing ServiceAccounts.
- **Prepare Underlying Infrastructure for Installing a Kubernetes Cluster**
  - Preparing nodes (disabling swap, configuring container runtime, etc.).
  - Setting up networking prerequisites and firewall rules.
- **Create and Manage Kubernetes Clusters Using kubeadm**
  - Installing kubeadm, kubelet, and kubectl.
  - Bootstrapping a cluster with `kubeadm init`.
  - Joining nodes to the cluster using `kubeadm join`.
- **Manage the Lifecycle of Kubernetes Clusters**
  - Upgrading the control plane and worker nodes.
  - Draining and cordoning nodes during maintenance.
- **Implement and Configure a Highly-Available Control Plane**
  - Understanding the control plane components.
  - Configuring HA setups (stacked etcd vs. external etcd).
  - Load balancing the API server.
- **Use Helm and Kustomize to Install Cluster Components**
  - Installing and managing cluster add-ons via Helm charts.
  - Customizing manifests using Kustomize overlays.
- **Understand Extension Interfaces (CNI, CSI, CRI, etc.)**
  - Container Network Interface (CNI) — choosing and installing network plugins (Calico, Flannel, Cilium).
  - Container Storage Interface (CSI) — how storage providers integrate with Kubernetes.
  - Container Runtime Interface (CRI) — understanding containerd, CRI-O.
- **Understand CRDs, Install and Configure Operators**
  - Creating and using Custom Resource Definitions (CRDs).
  - Understanding the Operator pattern.
  - Installing and managing Operators from OperatorHub or manifests.
