# Mock Exam 01

**Time Allotted:** 30 minutes
**Passing Score:** 100%

## Tasks

### Task 1: Context & Namespaces (Weight: 5%)
Create a namespace named `cka-practice-01`. All subsequent resources should be created in this namespace unless otherwise specified.

### Task 2: Pod & Node Affinity (Weight: 20%)
Create a pod named `web-server` using the `nginx:1.21` image.
Configure the pod so it will only be scheduled on a node with the label `disk=ssd`. 
(If no such node exists in your cluster, add the label to one of your worker nodes).

### Task 3: Deployments & Scaling (Weight: 20%)
Create a deployment named `redis-deploy` using the `redis:alpine` image with 3 replicas.
After creation, update the deployment to use the image `redis:7.0` and record the update in the rollout history.

### Task 4: Networking & Exposing Services (Weight: 20%)
Expose the `redis-deploy` deployment internally within the cluster on port `6379` using a Service named `redis-service`.

### Task 5: Network Policies (Weight: 20%)
Create a NetworkPolicy named `deny-redis-access`.
It should deny all incoming (Ingress) traffic to the pods managed by `redis-deploy`, except for traffic originating from pods that have the label `role=frontend`.

### Task 6: Troubleshooting & Logs (Weight: 15%)
Deploy a pod named `failing-pod` using the image `busybox` and the command `sleep xyz`. 
Output the exact error reason for the pod's failure into a file at `/tmp/pod-error.txt`.
