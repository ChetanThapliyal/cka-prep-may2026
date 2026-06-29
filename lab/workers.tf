# ============================================================
# CKA Practice Lab — Worker Nodes
# e2-medium | 2 vCPU | 4 GB RAM | 30 GB disk
# ============================================================

resource "google_compute_instance" "worker" {
  count        = var.worker_count
  name         = local.worker_names[count.index]
  machine_type = var.worker_machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      size  = 30
      type  = "pd-standard"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.subnet.id
    network_ip = local.worker_ips[count.index]

    access_config {
      # Ephemeral external IP
    }
  }

  metadata = {
    ssh-keys = "ubuntu:${tls_private_key.ssh.public_key_openssh}"
  }

  metadata_startup_script = join("\n", [
    templatefile("${path.module}/scripts/common-setup.sh.tftpl", local.common_script_vars),
    var.auto_cluster ? templatefile("${path.module}/scripts/worker-join.sh.tftpl", {
      controlplane_ip = local.controlplane_ip
      bootstrap_token = local.bootstrap_token
      node_name       = local.worker_names[count.index]
    }) : "echo '[CKA Lab] Manual mode — run kubeadm join yourself.'"
  ])

  tags = ["cka-lab"]

  service_account {
    scopes = ["cloud-platform"]
  }

  allow_stopping_for_update = true
}
