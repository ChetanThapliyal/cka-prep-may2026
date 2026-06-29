# ============================================================
# CKA Practice Lab — Control Plane Node
# e2-standard-2 | 2 vCPU | 8 GB RAM | 50 GB disk
# ============================================================

resource "google_compute_instance" "controlplane" {
  name         = "controlplane"
  machine_type = var.controlplane_machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      size  = 50
      type  = "pd-standard"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.subnet.id
    network_ip = local.controlplane_ip

    access_config {
      # Ephemeral external IP
    }
  }

  metadata = {
    ssh-keys = "ubuntu:${tls_private_key.ssh.public_key_openssh}"
  }

  metadata_startup_script = join("\n", [
    templatefile("${path.module}/scripts/common-setup.sh.tftpl", local.common_script_vars),
    var.auto_cluster ? templatefile("${path.module}/scripts/controlplane-init.sh.tftpl", {
      controlplane_ip = local.controlplane_ip
      pod_cidr        = local.pod_cidr
      bootstrap_token = local.bootstrap_token
    }) : "echo '[CKA Lab] Manual mode — run kubeadm init yourself.'"
  ])

  tags = ["cka-lab"]

  service_account {
    scopes = ["cloud-platform"]
  }

  allow_stopping_for_update = true
}
