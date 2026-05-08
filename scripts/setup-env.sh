#!/bin/bash

# CKA Exam Environment Setup Script
# Run this at the start of your practice sessions to build muscle memory.
# Usage: source setup-env.sh

echo "Configuring CKA Exam Environment..."

# 1. Kubectl Autocompletion
source <(kubectl completion bash)
complete -o default -F __start_kubectl k

# 2. Aliases
alias k=kubectl
alias kn='kubectl config set-context --current --namespace '

# 3. Time-saving exports
# Use $do to quickly generate YAML without applying it
export do="--dry-run=client -o yaml"
# Use $now to forcefully delete pods quickly (saves seconds waiting for grace period)
export now="--force --grace-period 0"

echo "Environment ready!"
echo "Try: k run test-pod --image=nginx $do > pod.yaml"
