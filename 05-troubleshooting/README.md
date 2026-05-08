# Troubleshooting (30%)

This is the largest domain in the CKA exam, making up 30%. It covers diagnosing and fixing issues at the cluster, node, application, and networking levels.

- **Troubleshoot Clusters and Nodes**
  - Diagnosing NotReady nodes and checking node conditions.
  - Inspecting kubelet logs on worker nodes (e.g., `journalctl -u kubelet`).
  - Verifying node resources and system Pod health.
  - Draining, cordoning, and uncordoning nodes.
- **Troubleshoot Cluster Components**
  - Locating and inspecting control plane component logs (kube-apiserver, kube-scheduler, kube-controller-manager, etcd).
  - Identifying issues with static Pod manifests in `/etc/kubernetes/manifests/`.
  - Diagnosing certificate and authentication problems.
- **Monitor Cluster and Application Resource Usage**
  - Using the Metrics Server to gather CPU and memory utilization.
  - Using `kubectl top nodes` and `kubectl top pods`.
  - Identifying resource bottlenecks and scheduling failures.
- **Manage and Evaluate Container Output Streams**
  - Viewing Pod and container logs using `kubectl logs`.
  - Troubleshooting crash loops and init container failures.
  - Streaming logs from multi-container Pods (`-c` flag).
- **Troubleshoot Services and Networking**
  - Diagnosing Service and Endpoint mapping issues.
  - Troubleshooting DNS resolution failures (CoreDNS).
  - Validating NetworkPolicy rules blocking legitimate traffic.
  - Using `kubectl exec` to test connectivity from within Pods.
