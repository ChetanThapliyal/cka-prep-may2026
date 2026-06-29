# ============================================================
# CKA Practice Lab — Main Infrastructure
# Provider config, networking, firewall, SSH key generation
# ============================================================

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">= 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.5"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 2.4"
    }
    http = {
      source  = "hashicorp/http"
      version = ">= 3.4"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

# ── Detect user's public IP for firewall rules ──────────────
data "http" "my_ip" {
  url = "https://api.ipify.org"
}

# ── Bootstrap token for kubeadm (auto mode) ─────────────────
resource "random_string" "token_id" {
  length  = 6
  special = false
  upper   = false
}

resource "random_string" "token_secret" {
  length  = 16
  special = false
  upper   = false
}

# ── SSH key pair (auto-generated) ────────────────────────────
resource "tls_private_key" "ssh" {
  algorithm = "ED25519"
}

resource "local_file" "ssh_private_key" {
  content         = tls_private_key.ssh.private_key_openssh
  filename        = "${path.module}/cka-lab-key"
  file_permission = "0600"
}

# ── Locals ───────────────────────────────────────────────────
locals {
  my_ip           = "${chomp(data.http.my_ip.response_body)}/32"
  controlplane_ip = "10.10.0.10"
  worker_ips      = ["10.10.0.21", "10.10.0.22"]
  worker_names    = ["worker-1", "worker-2"]
  pod_cidr        = "192.168.0.0/16"
  bootstrap_token = "${random_string.token_id.result}.${random_string.token_secret.result}"

  common_script_vars = {
    k8s_version     = var.k8s_version
    controlplane_ip = local.controlplane_ip
    worker1_ip      = local.worker_ips[0]
    worker2_ip      = local.worker_ips[1]
  }
}

# ── VPC Network ──────────────────────────────────────────────
resource "google_compute_network" "vpc" {
  name                    = "cka-lab-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = "cka-lab-subnet"
  ip_cidr_range = "10.10.0.0/24"
  region        = var.region
  network       = google_compute_network.vpc.id
}

# ── Firewall: Allow SSH from user's IP ───────────────────────
resource "google_compute_firewall" "allow_ssh" {
  name    = "cka-lab-allow-ssh"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = [local.my_ip]
  target_tags   = ["cka-lab"]
}

# ── Firewall: Allow all internal (node + pod CIDR) ───────────
resource "google_compute_firewall" "allow_internal" {
  name    = "cka-lab-allow-internal"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
  }
  allow {
    protocol = "udp"
  }
  allow {
    protocol = "icmp"
  }

  source_ranges = ["10.10.0.0/24", local.pod_cidr]
  target_tags   = ["cka-lab"]
}

# ── Firewall: Allow NodePort range from user's IP ────────────
resource "google_compute_firewall" "allow_nodeport" {
  name    = "cka-lab-allow-nodeport"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["30000-32767"]
  }

  source_ranges = [local.my_ip]
  target_tags   = ["cka-lab"]
}
