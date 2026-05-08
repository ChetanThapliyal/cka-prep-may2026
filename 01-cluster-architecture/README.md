# Cluster Architecture, Installation & Configuration (25%)

This section covers the management, installation, and configuration of a Kubernetes cluster, making up 25% of the CKA exam.

## Extensive Topic List

- **Manage Role-Based Access Control (RBAC)**
  - Creating Roles and ClusterRoles.
  - Creating RoleBindings and ClusterRoleBindings.
  - Managing ServiceAccounts.
- **Use Kubeadm to Install a Basic Cluster**
  - Installing kubeadm, kubelet, and kubectl.
  - Bootstrapping a cluster with `kubeadm init`.
  - Joining nodes to the cluster using `kubeadm join`.
- **Manage a Highly-Available Kubernetes Cluster**
  - Understanding the control plane components.
  - Configuring HA setups (stacked etcd vs. external etcd).
- **Provision Underlying Infrastructure to Deploy a Kubernetes Cluster**
  - Preparing nodes (disabling swap, configuring CRI, etc.).
- **Perform a Version Upgrade on a Kubernetes Cluster using Kubeadm**
  - Upgrading the control plane node.
  - Upgrading worker nodes.
  - Draining and cordoning nodes.
- **Implement etcd Backup and Restore**
  - Taking a snapshot of the etcd database using `etcdctl`.
  - Restoring a cluster from an etcd snapshot.
