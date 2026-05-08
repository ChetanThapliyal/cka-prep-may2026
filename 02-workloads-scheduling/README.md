# Workloads & Scheduling (15%)

This section covers the creation, management, and scheduling of workloads in Kubernetes, making up 15% of the CKA exam.

## Extensive Topic List

- **Understand Deployments and How to Perform Rolling Updates and Rollbacks**
  - Creating and managing Deployments.
  - Updating Deployments and checking rollout status.
  - Rolling back to a previous revision.
- **Use ConfigMaps and Secrets to Configure Applications**
  - Creating ConfigMaps and Secrets from literals, files, or directories.
  - Injecting ConfigMaps and Secrets as environment variables.
  - Mounting ConfigMaps and Secrets as volumes in Pods.
- **Know How to Scale Applications**
  - Imperative scaling using `kubectl scale`.
  - Declarative scaling via manifests.
- **Understand the Primitives Used to Create Robust, Self-Healing Application Deployments**
  - Using ReplicaSets directly and via Deployments.
  - DaemonSets for node-specific workloads.
  - StatefulSets for stateful applications.
- **Understand How Resource Limits Can Affect Pod Scheduling**
  - Configuring Resource Requests and Limits (CPU and Memory).
  - Understanding Pod eviction and OutOfMemory (OOM) errors.
- **Awareness of Manifest Management and Common Templating Tools**
  - Managing YAML manifests efficiently.
  - Basic understanding of Helm and Kustomize concepts.
