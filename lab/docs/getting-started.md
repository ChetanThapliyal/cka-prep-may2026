# Getting Started: CKA Practice Lab on GCP

This guide walks you through setting up everything from scratch — GCP project, billing, Terraform, and running your first practice session.

---

## Prerequisites

- A Google account
- A credit/debit card (for GCP billing — I have ~$20 in credits available in my billing account)
- A terminal with SSH access

---

## Phase 1: GCP Account & Project Setup

### Step 1: Install the Google Cloud CLI

```bash
# Ubuntu/Debian
curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list
sudo apt-get update && sudo apt-get install google-cloud-cli
```

Verify:

```bash
gcloud --version
```

### Step 2: Authenticate with Google Cloud

```bash
gcloud auth login
```

This opens a browser window. Sign in with your Google account.

### Step 3: Create a new GCP Project

```bash
gcloud projects create cka-lab-2026 --name="CKA Practice Lab"
```

> 💡 Project IDs must be globally unique. If `cka-lab-2026` is taken, try `cka-lab-<your-initials>-2026`.

Set it as the active project:

```bash
gcloud config set project cka-lab-2026
```

### Step 4: Enable billing

```bash
# List your billing accounts
gcloud billing accounts list

# Link billing to your project (replace BILLING_ACCOUNT_ID)
gcloud billing projects link cka-lab-2026 --billing-account=BILLING_ACCOUNT_ID
```

> ℹ️ With ~$20 in GCP credits, I can run approximately **50 practice sessions** (2-3 hrs each). A single session costs < $1.

### Step 5: Enable required APIs

```bash
gcloud services enable compute.googleapis.com --project=cka-lab-2026
```

### Step 6: Create Terraform service account credentials

```bash
# Create service account
gcloud iam service-accounts create terraform \
    --display-name="Terraform" \
    --project=cka-lab-2026

# Grant permissions
gcloud projects add-iam-policy-binding cka-lab-2026 \
    --member="serviceAccount:terraform@cka-lab-2026.iam.gserviceaccount.com" \
    --role="roles/editor"

# Download key file
gcloud iam service-accounts keys create ~/cka-terraform-key.json \
    --iam-account=terraform@cka-lab-2026.iam.gserviceaccount.com

# Set the environment variable Terraform will use
export GOOGLE_APPLICATION_CREDENTIALS=~/cka-terraform-key.json
```

> ⚠️ **Security:** Add `cka-terraform-key.json` to your global gitignore. Never commit service account keys.

---

## Phase 2: Install Terraform

### Option A: Direct install (Ubuntu/Debian)

```bash
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt-get update && sudo apt-get install terraform
```

### Option B: Binary install

```bash
curl -fsSL https://releases.hashicorp.com/terraform/1.9.0/terraform_1.9.0_linux_amd64.zip -o terraform.zip
unzip terraform.zip
sudo mv terraform /usr/local/bin/
rm terraform.zip
```

Verify:

```bash
terraform --version
```

---

## Phase 3: Launch the Lab

### Step 1: Configure your variables

```bash
cd ~/Apex/My-Projects/cka-prep/lab
cp terraform.tfvars.example terraform.tfvars
```

Edit `terraform.tfvars`:

```hcl
project_id = "cka-lab-2026"
region     = "asia-south1"
zone       = "asia-south1-a"
```

### Step 2: Initialize Terraform

```bash
terraform init
```

### Step 3: Choose your mode and apply

#### Mode 1: Manual (kubeadm practice)

```bash
terraform apply
```

This gives you 3 VMs with:

- ✅ Ubuntu 22.04
- ✅ containerd installed and running
- ✅ kubeadm, kubelet, kubectl installed (pinned to K8s 1.35)
- ✅ Swap disabled, kernel modules loaded, sysctl configured
- ❌ No cluster — you run `kubeadm init` and `kubeadm join` yourself

#### Mode 2: Auto (scenario practice)

```bash
terraform apply -var="auto_cluster=true"
```

This gives you everything from Mode 1 PLUS:

- ✅ `kubeadm init` completed on control plane
- ✅ Both workers joined the cluster
- ✅ Calico CNI installed (supports NetworkPolicy)
- ✅ Helm installed
- ✅ Cluster is Ready — start practicing immediately

### Step 4: Connect to your lab

After `terraform apply` completes, it will output SSH commands:

```
Outputs:

ssh_controlplane = "ssh -i ~/.ssh/cka-lab ubuntu@<EXTERNAL-IP>"
ssh_worker_1     = "ssh -i ~/.ssh/cka-lab ubuntu@<EXTERNAL-IP>"
ssh_worker_2     = "ssh -i ~/.ssh/cka-lab ubuntu@<EXTERNAL-IP>"
```

SSH into the control plane:

```bash
ssh -i ~/.ssh/cka-lab ubuntu@<CONTROLPLANE-IP>
```

---

## Phase 4: Run Practice Scenarios

### Step 1: Get the scripts onto the control plane

From the control plane VM:

```bash
git clone https://github.com/<your-username>/cka-prep.git ~/cka-prep
```

Or from your local machine:

```bash
scp -i ~/.ssh/cka-lab -r scenarios/ ubuntu@<CONTROLPLANE-IP>:~/scenarios/
```

### Step 2: Run a scenario

Each scenario has a setup script, your practice time, and a reset script:

```bash
# Set up a scenario (example: Gateway API migration)
bash ~/cka-prep/lab/scenarios/setup_gateway.sh

# ── Practice! ──

# When done, reset before next scenario
bash ~/cka-prep/lab/scenarios/reset_gateway.sh
```

### Step 3: Track your progress

After each scenario, note your time and any mistakes. The goal is to complete each one faster than the last.

---

## Phase 5: Tear Down (IMPORTANT!)

**Always destroy your lab after each session to avoid charges:**

```bash
cd ~/Apex/My-Projects/cka-prep/lab
terraform destroy
```

This deletes all 3 VMs, the VPC, firewall rules, and static IPs. Everything. Next session, just `terraform apply` again — fresh start in ~5 minutes.

> 💡 **Pro tip:** Create a shell alias for quick teardown:
>
> ```bash
> alias cka-down="cd ~/Apex/My-Projects/cka-prep/lab && terraform destroy -auto-approve"
> alias cka-up="cd ~/Apex/My-Projects/cka-prep/lab && terraform apply -var='auto_cluster=true' -auto-approve"
> ```

---

## Estimated Costs

| Scenario                           | Duration | Cost   |
| ---------------------------------- | -------- | ------ |
| Single practice session (2-3 hrs)  | 3 hours  | ~$0.40 |
| Daily practice for a week          | 21 hours | ~$2.84 |
| Weekend marathon (8 hrs/day × 2)   | 16 hours | ~$2.16 |
| Left running accidentally (24 hrs) | 24 hours | ~$3.24 |

> All estimates assume `asia-south1` pricing for `e2-standard-2` + 2× `e2-medium`.

**With your $20 budget:**

| Plan                          | Sessions     | Total hours | Total cost |
| ----------------------------- | ------------ | ----------- | ---------- |
| Conservative (3 hrs/session)  | ~50 sessions | ~150 hrs    | ~$20       |
| Intensive (daily for 2 weeks) | 14 sessions  | ~42 hrs     | ~$5.70     |

---

## Troubleshooting

### "Quota exceeded" error on `terraform apply`

GCP new accounts sometimes have low default quotas in certain regions.

```bash
# Check your compute quotas
gcloud compute regions describe asia-south1 --project=cka-lab-2026 | grep -A3 "CPUS"
```

If quota is too low, request an increase via the GCP Console → IAM & Admin → Quotas.

### SSH connection refused

Startup scripts take 2-3 minutes to complete. If SSH fails immediately after `terraform apply`, wait a minute and retry.

```bash
# Check if the VM is still running startup script
gcloud compute ssh controlplane --zone=asia-south1-a --command="sudo journalctl -u google-startup-scripts -f"
```

### kubeadm join fails (auto mode)

The join token is generated during `kubeadm init` and passed to workers via instance metadata. If workers boot faster than the control plane finishes init, the join script retries automatically (up to 5 minutes).

Check worker logs:

```bash
ssh -i ~/.ssh/cka-lab ubuntu@<WORKER-IP>
sudo cat /var/log/cka-setup.log
```

### "Error: project not found"

Ensure the project is set correctly:

```bash
gcloud config set project cka-lab-2026
gcloud projects describe cka-lab-2026
```

---

## What's Next?

Once the lab is running:

1. Start with **Mode 1 (manual)** — practice `kubeadm init` and `kubeadm join` at least 3 times until it's muscle memory.
2. Switch to **Mode 2 (auto)** for daily scenario practice.
3. Work through scenarios in order. Time yourself.
4. On the second pass, do them out of order to simulate the real exam.
5. Target completing each scenario under the exam's average time per question (~6 minutes).
