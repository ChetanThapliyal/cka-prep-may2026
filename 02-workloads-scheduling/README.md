# Workloads & Scheduling (15%)

This section covers the creation, management, and scheduling of workloads in Kubernetes, making up 15% of the CKA exam.

## Topics (2026 Syllabus)

- **Understand Application Deployments and How to Perform Rolling Updates and Rollbacks**
  - Creating and managing Deployments.
  - Updating Deployments and checking rollout status.
  - Rolling back to a previous revision.
- **Use ConfigMaps and Secrets to Configure Applications**
  - Creating ConfigMaps and Secrets from literals, files, or directories.
  - Injecting ConfigMaps and Secrets as environment variables.
  - Mounting ConfigMaps and Secrets as volumes in Pods.
- **Configure Workload Autoscaling**
  - Horizontal Pod Autoscaler (HPA) — scaling based on CPU/memory or custom metrics.
  - Understanding the Metrics Server requirement for HPA.
- **Understand the Primitives Used to Create Robust, Self-Healing Application Deployments**
  - Using ReplicaSets directly and via Deployments.
  - DaemonSets for node-specific workloads.
  - StatefulSets for stateful applications.
  - Jobs and CronJobs for batch workloads.
- **Configure Pod Admission and Scheduling (Limits, Node Affinity, etc.)**
  - Configuring Resource Requests and Limits (CPU and Memory).
  - Understanding Pod eviction and OutOfMemory (OOM) errors.
  - Node Selectors and Node Affinity rules.
  - Taints and Tolerations.
  - Pod Topology Spread Constraints.
