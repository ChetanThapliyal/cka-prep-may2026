# ADR-001: CKA Practice Lab Architecture

**Status:** Accepted
**Date:** 2026-05-28
**Context:** CKA exam preparation requires a repeatable, cost-effective Kubernetes lab environment.

---

## Decision

Build a Terraform-managed lab on Google Cloud Platform using 3 GCE VMs (1 control plane + 2 workers) with two operational modes: **manual kubeadm** and **auto-provisioned cluster**.

---

## Context & Problem

The CKA exam is a 100% hands-on, performance-based test inside a PSI Bridge remote desktop. Candidates must demonstrate proficiency with `kubeadm`, cluster troubleshooting, networking, storage, and workload management — all on real Linux VMs, not managed Kubernetes.

CKA practice scenarios fall into two categories with conflicting infrastructure needs:

- **Bootstrapping scenarios** (CRI configuration, CNI installation, kubeadm setup) require a **fresh, un-clustered VM** — you need to practice the bootstrapping process itself.
- **Workload scenarios** (NetworkPolicies, Ingress, storage, troubleshooting) require a **fully running kubeadm cluster** — spending 15 minutes on `kubeadm init` every time you want to practice a NetworkPolicy question is wasteful.

We need a solution that serves both needs without complexity overhead.

---

## Decisions Made

### 1. GCP over other cloud providers

| Factor                        | GCP    | AWS    | Local VMs (Vagrant) |
| ----------------------------- | ------ | ------ | ------------------- |
| Cost for 3 VMs (2-3 hrs)      | ~$0.40 | ~$0.50 | Free but slow       |
| Spin-up time                  | ~2 min | ~3 min | ~10 min             |
| Exam realism (Ubuntu VMs)     | ✅     | ✅     | ✅                  |
| Network realism (real IPs)    | ✅     | ✅     | ❌ NAT issues       |
| Hardware requirements         | None   | None   | 16 GB+ RAM          |
| Accessibility from any device | ✅ SSH | ✅ SSH | ❌ Local only       |

**Decision:** GCP. Existing credits cover initial practice. No local hardware dependency. `asia-south2` (Delhi) provides lowest latency.

### 2. Terraform only — no Ansible

**Considered:** Terraform for infra + Ansible for configuration management.

**Rejected because:**

- Ansible adds a dependency that must be installed and maintained on the local machine.
- The CKA exam does NOT use Ansible — there is no practice value in running Ansible playbooks.
- Everything Ansible would do (install containerd, configure sysctl, run kubeadm) can be done with GCE `metadata_startup_script` — a single bash script that runs on VM boot.
- Startup scripts are idempotent, require zero local tooling beyond Terraform, and are inspectable directly on the VM at `/var/log/syslog`.

**Decision:** Terraform + startup scripts. One tool, one `terraform apply`, done.

### 3. Two operational modes via a single variable

**Problem:** Manual kubeadm practice and scenario-based practice have conflicting needs.

**Solution:** A single Terraform variable `auto_cluster` (default: `false`) controls behavior:

| Mode   | Command                                    | What happens                                                                                                                                                     |
| ------ | ------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Manual | `terraform apply`                          | 3 VMs boot with OS prereqs (containerd, kubeadm, kubelet installed, swap disabled). You SSH in and run `kubeadm init`/`join` yourself.                           |
| Auto   | `terraform apply -var="auto_cluster=true"` | Same as above, PLUS: `kubeadm init` runs on control plane, `kubeadm join` runs on workers, Calico CNI installed, Helm installed. Cluster is ready in ~5 minutes. |

**Why not two separate Terraform configurations?**

- DRY violation — 90% of the code (VPC, firewall, VM definitions) would be duplicated.
- A single variable toggle is simpler to understand and maintain.

### 4. VM sizing: e2-standard-2 (control plane) + e2-medium (workers)

**Problem:** Practice scenarios often install heavy cluster components (ArgoCD, cert-manager, Ingress controllers, Gateway Fabric, Calico CNI, Metrics Server). Running multiple scenarios in a single session without resetting can stack up to 1.5 GB+ of overhead on the control plane.

**Decision:**

| Node         | Type            | vCPU | RAM  | Rationale                                                                                                           |
| ------------ | --------------- | ---- | ---- | ------------------------------------------------------------------------------------------------------------------- |
| controlplane | `e2-standard-2` | 2    | 8 GB | Runs API server + etcd + controllers + Helm-installed components. 4 GB is too tight when stacking multiple add-ons. |
| worker-1     | `e2-medium`     | 2    | 4 GB | Sufficient for workload pods. Matches exam environment constraints.                                                 |
| worker-2     | `e2-medium`     | 2    | 4 GB | Required for multi-node scheduling and drain/cordon practice.                                                       |

**Cost:** ~$0.135/hr total → **< $1 per 2-3 hour session** with `terraform destroy` after.

**Budget context:** With ~$20 in GCP credits, this allows **~50 practice sessions** (2-3 hrs each) or **~148 hours** of lab time — more than enough for thorough CKA preparation.

### 5. Two workers, not one or three

**Why not 1 worker?**

- Resource scheduling exercises require distributing pods across nodes.
- Drain/cordon exercises need at least one other worker to reschedule to.
- The real CKA exam environment has multiple nodes.

**Why not 3 workers?**

- No CKA topic requires more than 2 workers.
- Third worker adds ~$0.034/hr for no practice value — matters with a $20 budget.
- Two workers already allow affinity, taint/toleration, and drain exercises.

### 6. Ubuntu 22.04 as the base image

The CKA exam runs on an Ubuntu remote desktop with XFCE as the desktop environment, inside the PSI Bridge. XFCE is just the desktop shell — the underlying OS is Ubuntu. Using `ubuntu-2204-lts` ensures:

- Package manager commands (`apt-get`) match the exam.
- Kernel module paths and systemd service names are identical.
- Docker/containerd installation steps from practice questions work without modification.

### 7. Static internal IPs over dynamic

Control plane is assigned a static internal IP (`10.10.0.10`) because:

- `kubeadm init --apiserver-advertise-address` needs a predictable IP.
- Worker join commands reference the control plane IP.
- `/etc/hosts` entries in setup scripts can be hardcoded.
- Startup scripts can reference the control plane without discovery logic.

### 8. Firewall rules: minimal external, open internal

| Rule     | Source         | Ports       | Reason                                                     |
| -------- | -------------- | ----------- | ---------------------------------------------------------- |
| SSH      | User's IP only | 22          | Prevents unauthorized access. Determined dynamically.      |
| Internal | `10.10.0.0/24` | All         | Kubernetes components, pod networking, etcd communication. |
| NodePort | User's IP only | 30000-32767 | Testing NodePort Services and Ingress from local machine.  |

**Not opened:** API server port 6443 externally. All `kubectl` commands are run from inside the control plane VM via SSH — matching the exam experience where you work inside the remote desktop, not from your local machine.

### 9. Practice scripts live in the repo, not baked into the VM image

**Considered:** Building a custom GCE image with all setup/reset scripts pre-installed.

**Rejected because:**

- Custom images add build complexity and staleness risk.
- Scripts change frequently as we refine scenarios.
- `scp` or `git clone` from the control plane is trivial and always gets the latest version.
- Terraform `file` provisioner can push scripts at apply time if needed.

**Decision:** Scripts stay in the repo under `lab/scenarios/`. After `terraform apply`, user clones the repo or SCPs the scripts to the control plane.

---

## Consequences

### Positive

- Single `terraform apply` / `terraform destroy` cycle — no leftover resources, no surprise bills.
- Two modes cover 100% of practice scenarios without separate infrastructure.
- No local hardware requirements beyond a terminal with SSH.
- Cost is predictable and minimal (~$1/session).
- Environment closely matches the actual CKA exam.

### Negative

- Requires a GCP account with billing enabled (~$20 credits available).
- `asia-south2` availability may occasionally be constrained for `e2` instances.
- Auto mode takes ~5 minutes for cluster bootstrap — not instant.
- No persistent state between sessions — every `terraform destroy` + `apply` is a fresh start (this is intentional for exam practice but means no long-running experiments).

### Risks

- GCP credits run out (~$20 budget allows ~50 sessions) → mitigated by aggressive `terraform destroy` habit.
- Kubernetes version drift (exam uses 1.35, GCP may have newer) → mitigated by pinning `kubeadm` version in startup scripts.

---

## Alternatives Considered

| Alternative                          | Why rejected                                                                                                                        |
| ------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------- |
| **Kind (Kubernetes in Docker)**      | Single-machine, no real node separation. Cannot practice kubeadm, kubelet troubleshooting, or drain/cordon.                         |
| **Minikube**                         | Single-node. Same limitations as Kind for CKA-specific exercises.                                                                   |
| **Vagrant + VirtualBox**             | Requires 16 GB+ local RAM. Slow boot. NAT networking causes issues. Not accessible from other devices.                              |
| **AWS EC2**                          | Viable but no significant advantage over GCP. User already has GCP familiarity.                                                     |
| **Pre-built Killercoda/KillerShell** | Excellent for some scenarios but time-limited sessions, no customization, cannot practice all topics in one persistent environment. |
| **Terraform + Ansible**              | Adds unnecessary dependency. No practice value. Startup scripts achieve the same outcome with less complexity.                      |
