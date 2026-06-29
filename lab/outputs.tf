# ============================================================
# CKA Practice Lab — Outputs
# ============================================================

output "mode" {
  description = "Lab operation mode"
  value       = var.auto_cluster ? "AUTO — Cluster bootstrapped with Calico + Helm (~5 min)" : "MANUAL — SSH in and run kubeadm init/join yourself"
}

output "ssh_controlplane" {
  description = "SSH command for control plane"
  value       = "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i ${abspath(local_file.ssh_private_key.filename)} ubuntu@${google_compute_instance.controlplane.network_interface[0].access_config[0].nat_ip}"
}

output "ssh_workers" {
  description = "SSH commands for worker nodes"
  value = {
    for i, instance in google_compute_instance.worker :
    instance.name => "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i ${abspath(local_file.ssh_private_key.filename)} ubuntu@${instance.network_interface[0].access_config[0].nat_ip}"
  }
}

output "controlplane_external_ip" {
  description = "Control plane external IP"
  value       = google_compute_instance.controlplane.network_interface[0].access_config[0].nat_ip
}

output "controlplane_internal_ip" {
  description = "Control plane internal IP"
  value       = local.controlplane_ip
}

output "worker_external_ips" {
  description = "Worker node external IPs"
  value = {
    for i, instance in google_compute_instance.worker :
    instance.name => instance.network_interface[0].access_config[0].nat_ip
  }
}

output "kubeadm_init_hint" {
  description = "kubeadm init command for manual mode"
  value = var.auto_cluster ? "N/A — cluster bootstrapped automatically" : join(" ", [
    "sudo kubeadm init",
    "--apiserver-advertise-address=${local.controlplane_ip}",
    "--pod-network-cidr=${local.pod_cidr}",
    "--node-name=controlplane",
  ])
}
