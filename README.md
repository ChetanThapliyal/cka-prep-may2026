# CKA (Certified Kubernetes Administrator) Preparation

This repository contains study notes, practice manifests, and scripts for the Certified Kubernetes Administrator (CKA) exam.

## Repository Structure

- `01-cluster-architecture/`: Cluster Architecture, Installation & Configuration
- `02-workloads-scheduling/`: Workloads & Scheduling
- `03-services-networking/`: Services & Networking
- `04-storage/`: Storage
- `05-troubleshooting/`: Troubleshooting
- `lab/`: Terraform-based GCP practice lab (3-node kubeadm cluster)
- `scripts/`: Helper scripts for setting up practice environments
- `manifests/`: General practice YAML manifests

## Exam Objectives

> As of June 2026

- Cluster Architecture, Installation & Configuration: **25%**
- Workloads & Scheduling: **15%**
- Services & Networking: **20%**
- Storage: **10%**
- Troubleshooting: **30%**

## Exam Overview

### The Arena

- **Format:** 100% hands-on exam via PSI Bridge remote desktop.
- **Environment:** Ubuntu remote desktop with XFCE desktop environment, accessed via PSI Bridge.
- **Questions:** No multiple-choice questions.

### The Mission

- **Time Limit:** 2 hours
- **Workload:** 15 to 20 tasks
- **Passing Score:** 66%
- **Note:** Partial credit is awarded for incomplete tasks.

### The Loadout

One active browser tab is permitted, strictly limited to the following domains:

- [kubernetes.io/docs](https://kubernetes.io/docs/)
- [kubernetes.io/blog](https://kubernetes.io/blog/)
- [helm.sh/docs](https://helm.sh/docs/)
- [gateway-api.sigs.k8s.io](https://gateway-api.sigs.k8s.io/)

### Technical & Environmental Requirements

- **OS:** Windows 10/11 (64-bit), macOS 13.x+, or Ubuntu 22.04.
- **Software:** PSI Secure Browser (downloads at exam start) to access the PSI Bridge remote desktop. You must use the provided Firefox browser inside the remote desktop.
- **Hardware:**
  - **Screen:** 1920x1080 minimum (32-bit color). _Dual monitors are not supported._
  - **Webcam:** 640x480 minimum. Must provide a 360˚ room view (external camera required for desktops). You must remain centered in the frame.
  - **Mic/Network:** Functional microphone and at least 300 kbps up/down internet bandwidth.
- **Room Setup:** Must be private, quiet, and well-lit (no public spaces). Desk must be completely clear of papers and electronics.

### The Objective

The Administrator's role is to ensure reliability, performance, and availability by minimizing Mean Time to Acknowledge (MTTA) and Mean Time to Repair (MTTR).

## Resources

- [Kubernetes Documentation](https://kubernetes.io/docs/home/)
- [CKA Exam Details](https://training.linuxfoundation.org/certification/certified-kubernetes-administrator-cka/)
- [kubectl Cheat Sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)
- **[Exam Day Tips](CKA-tips.md)** — Study strategy, terminal handling, Vim essentials, and PSI Bridge navigation.
