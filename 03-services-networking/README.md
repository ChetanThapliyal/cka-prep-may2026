# Services & Networking (20%)

This section covers Kubernetes networking concepts, Services, and Ingress routing, making up 20% of the CKA exam.

## Extensive Topic List

- **Understand Host Networking Configuration on the Cluster Nodes**
  - Basic Linux networking and routing.
  - Examining node network interfaces and iptables.
- **Understand Connectivity Between Pods**
  - The Kubernetes networking model (every Pod gets a unique IP).
  - Pod-to-Pod communication across different nodes.
- **Understand ClusterIP, NodePort, LoadBalancer Service Types and Endpoints**
  - Creating and exposing Services.
  - Understanding how Endpoints map Services to Pods.
  - Differences between `ClusterIP`, `NodePort`, `LoadBalancer`, and `ExternalName`.
- **Know How to Use Ingress Controllers and Ingress Resources**
  - Installing and configuring an Ingress Controller (e.g., NGINX Ingress).
  - Creating Ingress resources to route HTTP/HTTPS traffic.
  - Configuring path-based and host-based routing.
- **Know How to Configure and Use CoreDNS**
  - Understanding internal DNS resolution for Services and Pods.
  - Troubleshooting CoreDNS configuration and logs.
- **Choose an Appropriate Container Network Interface (CNI) Plugin**
  - Installing and configuring a CNI plugin (e.g., Calico, Flannel, WeaveNet, Cilium).
  - Implementing Network Policies to restrict traffic between Pods.
