variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "asia-south1"
}

variable "zone" {
  description = "GCP zone"
  type        = string
  default     = "asia-south1-a"
}

variable "auto_cluster" {
  description = "If true, automatically bootstrap a kubeadm cluster with Calico CNI and Helm"
  type        = bool
  default     = false
}

variable "k8s_version" {
  description = "Kubernetes minor version (e.g., 1.34)"
  type        = string
  default     = "1.34"
}

variable "controlplane_machine_type" {
  description = "Machine type for the control plane node"
  type        = string
  default     = "e2-standard-2"
}

variable "worker_machine_type" {
  description = "Machine type for worker nodes"
  type        = string
  default     = "e2-medium"
}

variable "worker_count" {
  description = "Number of worker nodes"
  type        = number
  default     = 2
}
