# Services & Networking (20%)

This section covers Kubernetes networking concepts, Services, and traffic routing, making up 20% of the CKA exam.

- **Understand Connectivity Between Pods**
  - The Kubernetes networking model (every Pod gets a unique IP).
  - Pod-to-Pod communication across different nodes.
- **Define and Enforce Network Policies**
  - Creating Ingress and Egress NetworkPolicy rules.
  - Implementing default deny-all policies.
  - Allowing traffic from specific Pods, Namespaces, or IP blocks.
- **Use ClusterIP, NodePort, LoadBalancer Service Types and Endpoints**
  - Creating and exposing Services.
  - Understanding how Endpoints and EndpointSlices map Services to Pods.
  - Differences between `ClusterIP`, `NodePort`, `LoadBalancer`, and `ExternalName`.
- **Use the Gateway API to Manage Ingress Traffic**
  - Understanding the Gateway API as the successor to Ingress.
  - Creating GatewayClass, Gateway, and HTTPRoute resources.
  - Configuring path-based and host-based routing with Gateway API.
- **Know How to Use Ingress Controllers and Ingress Resources**
  - Installing and configuring an Ingress Controller (e.g., NGINX Ingress).
  - Creating Ingress resources to route HTTP/HTTPS traffic.
  - Configuring path-based and host-based routing.
- **Understand and Use CoreDNS**
  - Understanding internal DNS resolution for Services and Pods.
  - Troubleshooting CoreDNS configuration and logs.
  - Customizing CoreDNS with Corefile entries.
