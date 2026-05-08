# CKA Exam Allowed Bookmarks

During the CKA exam, you are permitted to use the official Kubernetes documentation. Having these exact search terms or URLs memorized/bookmarked for practice will save you critical time.

## Core Concepts & Generation
- [Kubectl Cheat Sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/) - *Crucial for quick commands.*

## Cluster Architecture & Upgrades
- [Kubeadm Upgrade Control Plane](https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/kubeadm-upgrade/)
- [Etcd Backup & Restore](https://kubernetes.io/docs/tasks/administer-cluster/configure-upgrade-etcd/#backing-up-an-etcd-cluster)

## Workloads & Scheduling
- [Static Pods](https://kubernetes.io/docs/tasks/configure-pod-container/static-pod/)
- [Node Affinity & Selector](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/)
- [Taints and Tolerations](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/)

## Storage
- [Persistent Volumes (PV) & PVCs](https://kubernetes.io/docs/tasks/configure-pod-container/configure-persistent-volume-storage/)

## Services & Networking
- [Network Policies](https://kubernetes.io/docs/concepts/services-networking/network-policies/) - *You must know how to copy the default deny/allow YAMLs quickly.*
- [Ingress Resource](https://kubernetes.io/docs/concepts/services-networking/ingress/#the-ingress-resource) - *Copying the basic Ingress YAML is faster than writing it.*

## Troubleshooting
- [Application Introspection and Debugging](https://kubernetes.io/docs/tasks/debug/debug-application/)
- [Determine the Reason for Pod Failure](https://kubernetes.io/docs/tasks/debug/debug-application/determine-reason-pod-failure/)
