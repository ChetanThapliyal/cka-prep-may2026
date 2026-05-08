# Troubleshooting (30%)

This is the largest domain in the CKA exam, making up 30%. It covers diagnosing and fixing issues at the application, node, and cluster levels.

## Extensive Topic List

- **Evaluate Cluster and Node Logging**
  - Locating and inspecting control plane logs (e.g., kube-apiserver, etcd).
  - Finding kubelet logs on worker nodes (e.g., `journalctl -u kubelet`).
- **Understand How to Monitor Applications**
  - Using the Metrics Server to gather CPU and memory utilization.
  - Using `kubectl top nodes` and `kubectl top pods`.
- **Manage Container Standard Output & Standard Error Logs**
  - Viewing Pod and container logs using `kubectl logs`.
  - Troubleshooting crash loops and init container failures.
- **Troubleshoot Application Failure**
  - Using `kubectl describe pod` to identify scheduling or image pull errors.
  - Executing into containers using `kubectl exec` to debug from within.
- **Troubleshoot Cluster Component Failure**
  - Diagnosing NotReady nodes and checking node conditions.
  - Identifying issues with the scheduler or controller-manager.
  - Uncordoning or draining nodes appropriately.
- **Troubleshoot Networking**
  - Diagnosing Service and Endpoint mapping issues.
  - Troubleshooting DNS resolution failures (CoreDNS).
  - Validating CNI installation and Network Policies blocking traffic.
